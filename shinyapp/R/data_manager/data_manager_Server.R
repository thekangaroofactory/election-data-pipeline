

# ------------------------------------------------------------------------------
# Shiny module server logic
# ------------------------------------------------------------------------------

data_manager_Server <- function(id, r, path) {
  moduleServer(id, function(input, output, session) {
    
    # -------------------------------------
    # Config
    # -------------------------------------
    
    # -- get namespace
    ns <- session$ns
    
    # -- parameters
    module <- paste0("[", id, "]")
    
    
    # -------------------------------------
    # Read data
    # -------------------------------------
    
    # -- store inputs
    r$datapath <- reactive(input$file_input$datapath)
    r$file_separator <- reactive(input$file_separator)
    r$file_encoding <- reactive(input$file_encoding)
    
    # -- read
    r$header <- eventReactive(input$file_input, {
      
      cat(module, "New file has been selected, loading data... \n")
      
      # -- read first line
      read.csv(input$file_input$datapath, header = TRUE, nrows = 10, sep = input$file_separator, fileEncoding = input$file_encoding)
      
    })
    
    
    # -- notify
    observeEvent(r$header(), {
      
      cat(module, "data loading done \n")
      showNotification(ui = "Header chargé", type = "message")
      
    })
    
    
    # -- preview
    output$content_preview <- renderTable(head(r$header(), n = 5))
    
    
  }) # -- end moduleServer
}
