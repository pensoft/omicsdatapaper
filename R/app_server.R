#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  #callModule(mod_first_module_server())
    #  setwd(golem::get_golem_wd())
  fpath <- system.file("extdata", "skeleton.xml", package="omicsdatapaper")
  xml = xml2::read_xml(fpath)
    #xml = get_golem_options("jats-skeleton")
   # xml = xml2::read_xml(paste0(golem::get_golem_wd(),"/jats-skeleton.xml"))
    observeEvent(input$go, {
      shinyWidgets::updateProgressBar(
        session = session,
        id = "pb1",
        value = 20
      )
      shinyjs::disable("downloadData")
      shinyjs::disable("downloadSuppl")
      shinyjs::disable("downloadHTML")
      
      display = reactive({
        display = process_study(input, xml)
      })
      
      
      output$out <- renderUI({HTML(display())})
      if (nchar(display())>1){
        shinyjs::enable("downloadData")
        shinyjs::enable("downloadHTML")
        
      }
      shinyWidgets::updateProgressBar(
        session = session,
        id = "pb1",
        value = 50
      )
      table = reactive({
        process_biosamples(input)
      })
      
      output$table <-  DT::renderDataTable({table()})
      
      if (nrow(table())>1){
        shinyjs::enable("downloadSuppl")
        shinyWidgets::updateProgressBar(
          session = session,
          id = "pb1",
          value = 100
        )
      }
    })
    
    output$downloadData = downloadHandler(
      filename = "omics_data_paper_jats.xml",
      content = function(file) {
        xml2::write_xml(xml2::read_xml("omics_data_paper_jats.xml"), file)
      }
    )
    
    output$downloadSuppl = downloadHandler(
      filename = "biosamples_mixs_checklist.csv",
      content = function(file) {
        utils::write.csv(utils::read.csv("biosamples_mixs_checklist.csv"), file, row.names = FALSE)
      }
    )
    
    output$downloadHTML = downloadHandler(
      filename = "omics_data_paper.html",
      content = function(file) {
        xml2::write_html(xml2::read_html("omics_data_paper.html"), file)
      }
    )
}
