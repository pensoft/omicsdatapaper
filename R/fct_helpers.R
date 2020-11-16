#' @export
process_biosamples = function(input){
  id= input$id[1] #get the id input by the user and send a request to ENA
  request = paste0("https://www.ebi.ac.uk/ena/browser/api/xml/", id)
  res = httr::content(httr::GET(request))
  biosamples_colnames = c("MIxS  field", "Value", "BioSample ID")
  sample_id = xml2::xml_text(xml2::xml_find_all(res, "//XREF_LINK/ID[../DB='ENA-SAMPLE']")) #getting all the sample ids and parsing them
  sample_ids = parse_multiple_ids(sample_id)
  if (length(sample_ids)>0){
    mixs_field = c() #declaring some of the variables (vectors) used for generating the data frame
    value = c()
    biosample_ids = c()
    biosamples_df = data.frame()
    for (s in 1:length(sample_ids)) { #iterating over each biosample id and sending requests to BioSample
      request = paste0("https://www.ebi.ac.uk/ena/browser/api/xml/", sample_ids[s])
      sample_res = httr::content(httr::GET(request))
      biosample_id = xml2::xml_text(xml2::xml_find_all(sample_res,"//SAMPLE/IDENTIFIERS/EXTERNAL_ID[@namespace='BioSample']"))
      if (length(biosample_id)>0){
        biosample_request = paste0("https://www.ebi.ac.uk/biosamples/samples/", biosample_id, ".xml")
        biosample_res = httr::content(httr::GET(biosample_request))
        biosample_xml = xml2::as_xml_document(biosample_res)
        properties = xml2::xml_children(biosample_xml) #getting all the mixs fields and their values
        counter = 0
        for (p in properties){
          if (xml2::xml_has_attr(p, "class")){ #there is one child node which is not named "Property" but "Database"
            property_class = xml2::xml_text(xml2::xml_find_all(p, "@class"))
            mixs_field = c(mixs_field, property_class)
            qualified_values = xml2::xml_children(xml2::as_xml_document(p))
            values = xml2::xml_text(xml2::xml_find_all(qualified_values[1], "."))
            value = c(value, values)
            counter = counter+1
          }
        }
        biosample_ids = c(biosample_ids, rep(biosample_id, counter)) #adding a third vector with the biosample id
      }
    }
    
    biosamples_df = data.frame(mixs_field, value, biosample_ids) #creating the data frame
    colnames(biosamples_df) = biosamples_colnames
    utils::write.csv(biosamples_df, file = "biosamples_mixs_checklist.csv", row.names = FALSE)
    
  }else{
    biosamples_df = NULL
  }
  return(biosamples_df)
}

#' @export
#function to obtain metadata from ENA and ArrayExpress
process_study = function(input, xml){
  id= input$id[1]
  request = paste0("https://www.ebi.ac.uk/ena/browser/api/xml/", id)
  res = httr::content(httr::GET(request))
  keywords = c()
  doc = XML::xmlTreeParse(res)
  root_name = XML::xmlName(XML::xmlRoot(doc)[[1]])
  title = ""
  if (root_name == "PROJECT"){
    title = xml2::xml_text(xml2::xml_find_all(res, paste0("//", root_name, "/TITLE")))
  } else if (root_name == "STUDY"){
    title = xml2::xml_text(xml2::xml_find_all(res, paste0("//", root_name, "_TITLE")))
  } else{
    title = xml2::xml_text(xml2::xml_find_all(res, paste0("//", root_name, "TITLE")))
  }
  abstract = xml2::xml_text(xml2::xml_find_all(res,  paste0("//", root_name, "_ABSTRACT")))
  if (length(abstract)<1){
    abstract = xml2::xml_text(xml2::xml_find_all(res, "//DESCRIPTION"))
  }
  
  #populate title and abstract within jats xml
  title_node = xml2::xml_find_first(xml, "/article/front/article-meta/title-group/article-title")
  xml2::xml_text(title_node) = title
  
  abstract_node = xml2::xml_find_first(xml, "/article/front/article-meta/abstract")
  xml2::xml_add_child(abstract_node, "p")
  abstract_node_p = xml2::xml_find_first(xml, "/article/front/article-meta/abstract/p")
  xml2::xml_text(abstract_node_p) = abstract
  
  #getting the data resources
  fastq_files = xml2::xml_text(xml2::xml_find_all(res,"//XREF_LINK/ID[../DB='ENA-FASTQ-FILES']"))
  ena_run_id = xml2::xml_text(xml2::xml_find_all(res, "//XREF_LINK/ID[../DB='ENA-RUN']"))
  res_fastq = httr::content(httr::GET(fastq_files))
  res_fastq = strsplit(res_fastq, "\n")
  res_fastq = res_fastq[[1]]
  res_fastq = res_fastq[2:length(res_fastq)]
  res_links = c()
  res_identifiers = c()
  counter = 0
  data_resources = c()
  for (r in 1:length(res_fastq)){
    components = strsplit(res_fastq[r], "\t")
    identifier = components[[1]][1]
    link = components[[1]][2]
    links = strsplit(link, ";")
    link_1 = links[[1]][1]
    link_2 = links[[1]][2]
    if (is.na(link_2)){
      link_2=""
    }
    data_resource = paste("<h3 style=\"color:DARKCYAN;\">Resource ", r, "</h3>", "<h4 style=\"color:LIGHTSEAGREEN;\">Download URL</h4>", link_1, "\n", link_2,  "<h4 style=\"color:LIGHTSEAGREEN;\">Resource identifier</h4>", identifier, "<h4 style=\"color:LIGHTSEAGREEN;\">Data format</h4>", "FASTQ")
    data_resources = c(data_resources, data_resource) 
    
    #add data resources to jats xml
    dr_node = xml2::xml_find_first(xml, "/article/body/sec[@sec-type='Data resources']")
    xml2::xml_add_child(dr_node, "sec")
    new_sec_xpath = paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]")
    x = xml2::xml_find_first(xml, new_sec_xpath)
    xml2::xml_add_child(x, "title")
    title_xpath = paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/title")
    title_node =xml2::xml_find_first(xml, title_xpath)
    xml2::xml_text(title_node) = paste0("Resource ", r)
    xml2::xml_attr(x, "sec-type") = paste0("Resource ", r)
    #download url(s)
    xml2::xml_add_child(x, "sec")
    download_url_xpath = paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/sec")
    download_url_node = xml2::xml_find_first(xml, download_url_xpath)
    xml2::xml_attr(download_url_node, "sec-type") = "Download URL"
    xml2::xml_add_child(download_url_node, "p")
    download_url_node_p = xml2::xml_find_all(xml, paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/sec[@sec-type='Download URL']/p"))
    xml2::xml_add_child(download_url_node_p, "ext-link")
    ext_link_xpath = paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/sec[@sec-type='Download URL']/p/ext-link")
    ext_link_attrs = c("simple", "uri", link_1)
    names(ext_link_attrs) = c("xlink:type", "ext-link-type", "xlink:href")
    ext_link_node = xml2::xml_find_first(xml, ext_link_xpath)
    xml2::xml_set_attrs(ext_link_node, ext_link_attrs)
    xml2::xml_text(ext_link_node) = link_1
    #check if there is a second url (for the reverse reads) and add node
    if (nchar(link_2) > 0){
      xml2::xml_add_sibling(ext_link_node, "ext-link")
      ext_link_xpath_2 = paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/sec[@sec-type='Download URL']/p/ext-link[2]")
      ext_link_node_2 = xml2::xml_find_first(xml, ext_link_xpath_2)
      ext_link_attrs_2 = c("simple", "uri", link_2)
      names(ext_link_attrs_2) = c("xlink:type", "ext-link-type", "xlink:href")
      xml2::xml_set_attrs(ext_link_node_2, ext_link_attrs_2)
      xml2::xml_text(ext_link_node_2) = link_2
    }
    
    #title of section
    xml2::xml_add_sibling(download_url_node_p, "title", .where = "before")
    download_title_node=xml2::xml_find_all(xml, paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/sec[@sec-type='Download URL']/title"))
    xml2::xml_text(download_title_node) = "Download URL"
    
    #resource identifier
    xml2::xml_add_child(x, "sec")
    res_id_xpath = paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/sec[2]")
    res_id_node= xml2::xml_find_all(xml, res_id_xpath)
    xml2::xml_attr(res_id_node, "sec-type") = "Resource identifier"
    xml2::xml_add_child(res_id_node, "p")
    res_id_node_p =  xml2::xml_find_all(xml, paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/sec[@sec-type='Resource identifier']/p"))
    xml2::xml_text(res_id_node_p) = identifier
    
    #title of section
    xml2::xml_add_sibling(res_id_node_p, "title", .where = "before") #here we create the title node, before the text of the res node
    res_text_title = xml2::xml_find_all(xml,  paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/sec[@sec-type='Resource identifier']/p/title"))
    xml2::xml_text(res_text_title) = "Resource identifier"
    
    #data format
    xml2::xml_add_child(x, "sec")
    data_format_xpath = paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/sec[3]")
    data_format_node = xml2::xml_find_all(xml, data_format_xpath)
    xml2::xml_attr(data_format_node, "sec-type") = "Data format"
    xml2::xml_add_child(data_format_node, "p")
    data_format_node_p =  xml2::xml_find_all(xml, paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/sec[@sec-type='Data format']/p"))
    xml2::xml_text(data_format_node_p) = "FASTQ"
    
    #title of section
    xml2::xml_add_sibling(data_format_node_p, "title", .where = "before") #here we create the title node, before the text of the res node
    format_text_title = xml2::xml_find_all(xml,  paste0("/article/body/sec[@sec-type='Data resources']/sec[", r, "]/sec[@sec-type='Data format']/title"))
    xml2::xml_text(format_text_title) = "Data format"
  }
  
  
  dr = paste(data_resources, sep = " ", collapse = "</br>")
  sample_id = xml2::xml_text(xml2::xml_find_all(res, "//XREF_LINK/ID[../DB='ENA-SAMPLE']"))
  experiment_id =  xml2::xml_text(xml2::xml_find_all(res, "//XREF_LINK/ID[../DB='ENA-EXPERIMENT']"))
  arrayexpress_id = xml2::xml_text(xml2::xml_find_all(res,  paste0("//", root_name,"/@alias[../@broker_name='ArrayExpress']")))
  #getting ArrayExpress metadata if it exists
  if (length(arrayexpress_id)>0){
    request = paste0("https://www.ebi.ac.uk/arrayexpress/xml/v3/experiments/", arrayexpress_id)
    ae_res = httr::content(httr::GET(request))
    protocol_ids = xml2::xml_text(xml2::xml_find_all(ae_res, "//protocol/accession"))
  }else{
    protocol_ids = NULL
  }
  #getting sample metadata
  sample_ids = parse_multiple_ids(sample_id)
  experiment_ids =  parse_multiple_ids(experiment_id)
  sample_info = c()
  sample_info_for_xml = c()
  organism_name = c()
  if (length(sample_ids)>0){
    for (s in 1:length(sample_ids)) {
      request = paste0("https://www.ebi.ac.uk/ena/browser/api/xml/", sample_ids[s])
      sample_res = httr::content(httr::GET(request))
      organism_name = c(organism_name, xml2::xml_text(xml2::xml_find_all(sample_res,"//SCIENTIFIC_NAME")))
      keywords = c(keywords, organism_name)
      sample_description = xml2::xml_text(xml2::xml_find_all(sample_res,"//SAMPLE/DESCRIPTION"))
      if (is.null(sample_description))
        sample_description = ""
      sample_atts =  xml2::xml_find_all(sample_res,"//SAMPLE/SAMPLE_ATTRIBUTES/SAMPLE_ATTRIBUTE")
      sample_characteristics = ""
      sample_characteristics = sapply(sample_atts, function(n){
        
        tag = xml2::xml_text(xml2::xml_find_all(n, "./TAG"))
        if (grepl("[A-Z]", tag) == FALSE){
          value = xml2::xml_text(xml2::xml_find_all(n, "./VALUE"))
          sample_characteristics = paste0(tag, " :", value, "; ")
        }else{
          sample_characteristics = ""
        }
      })
      sample_characteristics_for_xml = paste(sample_characteristics, collapse = "\n")
      sample_characteristics = paste(sample_characteristics, collapse = "<br/>")
      sample_info_for_xml =  c(sample_info_for_xml, paste(organism_name, sample_description, sample_characteristics_for_xml))
      sample_info = c(sample_info, paste("<h4>", organism_name,"</h4", "<br/>", sample_description, "<br/><br/>", sample_characteristics, "<br/>"))
    }
  }
  
  #add organism name to jats xml
  taxonomic_node = xml2::xml_find_all(xml, "/article/body/sec[@sec-type='Biodiversity profile']/sec[@sec-type='Taxonomic range']")
  xml2::xml_add_child(taxonomic_node, "list", .where=1)
  taxonomic_list_node = xml2::xml_find_all(xml, "/article/body/sec[@sec-type='Biodiversity profile']/sec[@sec-type='Taxonomic range']/list")
  organism_name = unique(organism_name)
  for (o in 1:length(organism_name)){
    xml2::xml_add_child(taxonomic_list_node, "list-item")
    taxonomic_list_item_node = xml2::xml_find_all(xml, paste0("/article/body/sec[@sec-type='Biodiversity profile']/sec[@sec-type='Taxonomic range']/list/list-item[", o, "]"))
    xml2::xml_add_child(taxonomic_list_item_node, "p")
    taxonomic_list_item_node_p = xml2::xml_find_all(xml, paste0("/article/body/sec[@sec-type='Biodiversity profile']/sec[@sec-type='Taxonomic range']/list/list-item[", o, "]/p"))
    xml2::xml_text(taxonomic_list_item_node_p) = organism_name
  }
  
  # text_node = xml2::xml_find_all(xml, "/article/body/sec[@sec-type='Biodiversity profile']/sec[@sec-type='Taxonomic range']/text() ")
  xml2::xml_add_sibling(taxonomic_list_node, "title", .where = "before") #here we create the title node, before the text of the target node
  taxonomic_title = xml2::xml_find_all(xml, "/article/body/sec[@sec-type='Biodiversity profile']/sec[@sec-type='Taxonomic range']/title")
  xml2::xml_text(taxonomic_title) = "Taxonomic range"
  
  #getting experiment (methods) metadata
  experiment_info = c()
  library_strategies = c()
  
  sequencing_platforms = c()
  if (length(experiment_ids)>0){
    for (s in 1:length(experiment_ids)) {
      request = paste0("https://www.ebi.ac.uk/ena/browser/api/xml/", experiment_ids[s])
      ena_experiment = httr::content(httr::GET(request))
      library_strategy =  xml2::xml_text(xml2::xml_find_all(ena_experiment,"//EXPERIMENT/DESIGN/LIBRARY_DESCRIPTOR/LIBRARY_STRATEGY"))
      sequencing_platform = xml2::xml_text(xml2::xml_find_all(ena_experiment,"//EXPERIMENT/PLATFORM"))
      spot_count = xml2::xml_text(xml2::xml_find_all(ena_experiment,"//EXPERIMENT/EXPERIMENT_ATTRIBUTES/EXPERIMENT_ATTRIBUTE/VALUE[../TAG='ENA-SPOT-COUNT']"))
      base_count = xml2::xml_text(xml2::xml_find_all(ena_experiment,"//EXPERIMENT/EXPERIMENT_ATTRIBUTES/EXPERIMENT_ATTRIBUTE/VALUE[../TAG='ENA-BASE-COUNT']"))
      library_strategies = c(library_strategies, library_strategy)
      sequencing_platforms = c(sequencing_platforms, sequencing_platform)
    }
    sequencing_platforms = unique(sequencing_platforms)
    library_strategies = unique(library_strategies)
    library_strategies  = paste(library_strategies, collapse = ", ")
    keywords = c(keywords, sequencing_platforms)
    keywords = c(keywords, library_strategies)
  }
  sequencing_platforms = paste(sequencing_platforms, collapse = ", ")
  
  #setting the target in the xml
  target_node = xml2::xml_find_all(xml, "/article/body/sec[@sec-type='Biodiversity profile']/sec[@sec-type='Target']")
  xml2::xml_add_child(target_node, "p")
  target_node_p=xml2::xml_find_all(xml, "/article/body/sec[@sec-type='Biodiversity profile']/sec[@sec-type='Target']/p")
  xml2::xml_text(target_node_p) = library_strategies
  xml2::xml_add_sibling(target_node_p, "title", .where = "before") #here we create the title node, before the text of the target node
  target_title = xml2::xml_find_all(xml, "/article/body/sec[@sec-type='Biodiversity profile']/sec[@sec-type='Target']/title")
  xml2::xml_text(target_title) = "Target"
  
  protocol_ids = sort(protocol_ids)
  protocols = c()
  if (length(protocol_ids>0)){
    #requests for each protocol:
    protocols = sapply(protocol_ids, function(n){
      request = paste0("https://www.ebi.ac.uk/arrayexpress/xml/v3/protocols/", n)
      protocol_res = httr::content(httr::GET(request))
      protocol_title = xml2::xml_text(xml2::xml_find_all(protocol_res, "protocol/type"))
      protocol_title = paste("<h4>", protocol_title, "</h4>")
      protocol_text =  xml2::xml_text(xml2::xml_find_all(protocol_res, "protocol/text"))
      hardware = xml2::xml_text(xml2::xml_find_all(protocol_res, "protocol/hardware"))
      software = xml2::xml_text(xml2::xml_find_all(protocol_res, "protocol/software"))
      performer = xml2::xml_text(xml2::xml_find_all(protocol_res, "protocol/performer"))
      protocol = paste0(tools::toTitleCase(protocol_title), "<br/>", protocol_text, "<br/>")
      if (!(performer=="")){
        protocol = paste0(protocol, "Performed by: ", performer, "<br/>")
      }
      if (!(hardware=="")){
        protocol = paste0(protocol, "Hardware used: ", hardware, "<br/>")
      }
      if (!(software=="")){
        protocol = paste0(protocol, "Software used: ", software, "<br/>")
      }
      protocols = c(protocols, protocol)
    })
  }
  
  steps = paste(protocols, collapse = "<br/>")
  sample_info = unique(sample_info)
  sample_info = paste(sample_info, collapse = "<br/>")
  sample_info_for_xml = unique(sample_info_for_xml)
  sampling_node = xml2::xml_find_all(xml, "/article/body/sec[@sec-type='Methods']/sec[@sec-type='Sampling']")
  xml2::xml_add_child(sampling_node, "list", .where=1)
  list_node = xml2::xml_find_all(xml, "/article/body/sec[@sec-type='Methods']/sec[@sec-type='Sampling']/list")
  for (s in 1:length(sample_info_for_xml)){
    xml2::xml_add_child(list_node, "list-item")
    list_node_item = xml2::xml_find_all(xml, paste0("/article/body/sec[@sec-type='Methods']/sec[@sec-type='Sampling']/list/list-item[", s, "]"))
    xml2::xml_add_child(list_node_item, "p")
  }
  
  for (l in 1:length(sample_info_for_xml)){
    list_item = xml2::xml_find_all(xml, paste0("/article/body/sec[@sec-type='Methods']/sec[@sec-type='Sampling']/list/list-item[", l,"]/p"))
    xml2::xml_text(list_item) = sample_info_for_xml[l]
  }
  
  keywords = unique(keywords)
  
  kwd_group_node = xml2::xml_find_all(xml, "/article/front/article-meta/kwd-group")
  for (k in 1:length(keywords)){
    xml2::xml_add_child(kwd_group_node, "kwd")
    kwd_node = xml2::xml_find_all(xml, paste0("/article/front/article-meta/kwd-group/kwd[", k, "]"))
    xml2::xml_text(kwd_node) = keywords[k]
  }
  
  keywords = paste(keywords, collapse = ", ")
  
  xml2::write_xml(xml, "omics_data_paper_jats.xml")
  #display html formatted text
  display = c()
  display = paste(paste("<h1 style=\"color:TEAL;\">", title, "</h1>"), "<h2 style=\"color:DARKCYAN;\">Abstract</h2>", abstract, "<h2 style=\"color:DARKCYAN;\">Keywords</h2>", keywords, sep="<br/>")
  display = paste(display, "<h2 style=\"color:DARKCYAN;\">Introduction</h2>", " ", " ", "<h3 style=\"color:DARKCYAN;\">Value of the dataset</h3>", " ", "<h4 style=\"color:LIGHTSEAGREEN;\">Scientific value</h4>", "<h4 style=\"color:LIGHTSEAGREEN;\">Societal value</h4>", sep = "<br/>")
  display = paste(display, "<h2 style=\"color:DARKCYAN;\">Methods</h2>", steps, "<h3 style=\"color:DARKCYAN;\">Sampling</h3>", sample_info, "<h4 style=\"color:LIGHTSEAGREEN;\">Environmental profile </h4>", " ", "<h4 style=\"color:LIGHTSEAGREEN;\">Geographic range </h4>", " ", "<h4 style=\"color:LIGHTSEAGREEN;\">Technologies used</h4>",  sep = "<br/>")
  display = paste(display, "<h3 style=\"color:DARKCYAN;\">Sample processing</h3>", "<h4 style=\"color:LIGHTSEAGREEN;\">Technologies used</h4>", sequencing_platforms, sep = "<br/>")
  display = paste(display, "<h3 style=\"color:DARKCYAN;\">Data processing</h3>", " ", " ",  "<h4 style=\"color:LIGHTSEAGREEN;\">Technologies used</h4>", sep = "<br/>")
  display = paste(display, "<h2 style=\"color:DARKCYAN;\">Biodiversity profile</h2>", " ", "<h3 style=\"color:DARKCYAN;\">Target</h3>", library_strategies, "<h3 style=\"color:DARKCYAN;\">Taxonomic range</h3>", organism_name, "<h3 style=\"color:DARKCYAN;\">Functional range</h3>", " ", "<h3 style=\"color:DARKCYAN;\">Traits</h3>", " ", sep = "<br/>")
  display = paste(display, "<h2 style=\"color:DARKCYAN;\">Data Resources</h2>", dr,  sep = "<br/>")
  display = paste(display, "<h2 style=\"color:DARKCYAN;\">Data statistics</h2>", "", "<h2 style=\"color:DARKCYAN;\">Caveats and limitations</h2>", "", "<h2 style=\"color:DARKCYAN;\">Usage rights</h2>", sep = "<br/>")
  display = paste(display, "<h2 style=\"color:DARKCYAN;\">Supplementary material</h2>", " ", "<h3 style=\"color:DARKCYAN;\">Suppl. material 1: BioSamples MIxS checklists</h3>", " ", "<h4 style=\"color:LIGHTSEAGREEN;\">Data type: sample metadata</h4>", " ", "<h4 style=\"color:LIGHTSEAGREEN;\">Filename: biosamples_mixs_checklist.csv</h4>", " ")
  display_html = paste(as.character(display), collapse = "\n")
  
  utils::write.table(display_html, 
              file="omics_data_paper.html", 
              quote = FALSE,
              col.names = FALSE,
              row.names = FALSE)
  return(display)
}

#' @export
parse_multiple_ids = function(id){
  if (length(id)>0){
    #check whether the separating character is - or ,
    #first check both
    if (grepl(",", id) && grepl("-", id)){
      #first split only based on ,
      ids = unlist(strsplit(id, ","))
      new_ids = c()
      new_ids = sapply(ids, function(i){
        if (grepl("-", i)){
          new_ids = parse_consecutive_ids(i)
        }else{
          new_ids = c(new_ids, i)
        }
      })
      names(new_ids) = NULL
      new_ids = unlist(new_ids)
    }else if (grepl("-", id)){
      new_ids = c()
      new_ids = sapply(id, function(i){
        if (grepl("-", i)){
          new_ids = parse_consecutive_ids(i)
        }else{
          new_ids = c(new_ids, i)
        }
      })
      names(new_ids) = NULL
      new_ids = unlist(new_ids)
    }else{
      new_ids = unlist(strsplit(id, ","))
    }
  }else{
    new_ids = id
  }
  return(new_ids)
}

#' @export
parse_consecutive_ids = function(id){
  #e.g. DRX016751-DRX016758
  #split
  #extract number
  ids = unlist(strsplit(id, "-"))
  second_number = stringr::str_extract(ids[2], "[^a-zA-Z0][0-9]*?$")
  first_number =  stringr::str_extract(ids[1], "[^a-zA-Z0][0-9]*?$")
  diff = as.numeric(second_number)-as.numeric(first_number)
  letter_prefix = stringr::str_extract(ids[1], "^[a-zA-Z0]*")
  new_ids = c(ids[1])
  for (i in 1:diff){
    new_num = as.numeric(first_number)+i
    new_id = paste0(letter_prefix, new_num)
    new_ids = c(new_ids, new_id)
  }
  return(new_ids)
}
#' helpers function
#'
#' @description A shiny function
#'
#' @param Internal parameters for the function.
#'
#' @return The return value, if any, from executing the function.
#'
#' @export
