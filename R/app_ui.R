#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    #generate the reactive shiny app 
    fluidPage(
      shinyjs::useShinyjs(),
      tags$head(tags$style(" .headerRow{background-color: #033F63;color:white;}")),
      tags$head(tags$style(" .bodyRow{background-color: #f7f9f9;color:#313638;margin-top:15px;}")),
      tags$head(tags$style(" .progress-bar{background-color:#033F63;}")),
      tags$head(tags$style(HTML("a {color: #E891A8}"))),
      tags$head(tags$style(HTML("a:hover {color: #F5D1DA}"))),

      fluidRow(class="headerRow",
               h1("Genomic Data Paper Generator", style="margin-left: 15px"),
               h4("The application demonstrates the automatic import of ENA metadata into genomics data paper manuscript, implemented as a workflow in Pensoft's", a(href="https://arpha.pensoft.net/", "ARPHA Writing Tool"),". The code behind this R shiny app is ", a(href="https://github.com/pensoft/omics-data-paper-shinyapp", "available on GitHub"), "under Apache 2.0 license and can be used and modified by anyone with the right attribution.",
                  style="margin-left: 15px; margin-right:40px; text-align: justify;"),
               h4("You can read more about the project in ", a(href="https://blog.pensoft.net/2020/06/16/streamlined-import-of-omics-metadata-from-the-european-nucleotide-archive-ena-into-an-omics-data-paper-manuscript/", "this blogpost."),
                  style="margin-left: 15px; margin-right:40px; text-align: justify;"),
            #   h4("The generated genomics data paper follows a predefined structure, defined by our omics data paper template.",
             #     style="margin-left: 15px; margin-right:40px; text-align: justify;"),
            #   column(12, actionButton("help", "Paper structure")),
            #   column(12, "               "),
            #   column(12, "               "),
            #   column(12, "               "),
               
      ),
      fluidRow(class="bodyRow", 
               column(12, h4("Omics data paper structure"))
      ),
      fluidRow(class="bodyRow", 
               column(12, h5("The generated genomics data paper follows a predefined template. We suggest reading about it to better understand the rationale behind the omics data paper structure."))
               ),
      fluidRow(class="bodyRow", 
               column(4,
                      actionButton("help", "Read more"))
               ),
      fluidRow(class="bodyRow", 
               column(12, h4("Import genomic metadata into manuscript"))
      ),
      fluidRow(class="bodyRow",
               column(4,
                      textInput(inputId = "id", label = "Enter ENA Study accession number", value =  "PRJDB2900", width = 600),
                      padding = 2000,
               ),
               column(8,
                      actionButton("go", "Import", style="margin-top:20px;"),
                      
               ),
               
               conditionalPanel(
                 condition=("input.go == 1"),
                 column(12,
                        downloadButton("downloadData", "Download XML"),
                        downloadButton("downloadHTML", "Download HTML"),
                        downloadButton("downloadSuppl", "Download Supplementary Material"),
                 ),
                 #   withSpinner(uiOutput("spinnerDummyID1"), type = 1)
               )
               
               ,
               column(12,
                      htmlOutput(outputId  = "out"), style="width:1200px;margin-right:20px;margin-left:40px;margin-top:10px"),
               
               column(12,
                      DT::DTOutput(outputId = "table"), style="margin-top:10px"
               )
      ),
      shinyWidgets::progressBar(id = "pb1", value = 0),
      h5("This research has received funding from the European Union’s Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant agreement No 764840 as part of the International Training Network (ITN) IGNITE.", style="margin-left: 15px"),
    )
  )
}


#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'omicsdatapaper'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

