#' Run the Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
  ...
) {
  with_golem_options(
    app = shinyApp(
      ui = app_ui, 
      server = app_server
      #options = options,
      #jats_skeleton = omicsdatapaper::skeleton
    ), 
    golem_opts = list(...)
   # golem_opts(mydata = mypkg::mydata)
)
}


