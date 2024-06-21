

# ------------------------------------------------------------------------------
# Server definition of the Shiny web application
# ------------------------------------------------------------------------------

# -- Define server logic
shinyServer(
  function(input, output){
    
    cat("\n-------------------------------------------------- \n")
    cat("Starting application server \n")
    cat("-------------------------------------------------- \n")
    
    # -------------------------------------
    # Declare parameters
    # -------------------------------------
    
    # -- global communication object
    r <- reactiveValues()
    
    
    # -------------------------------------
    # Select file to process
    # -------------------------------------
    
    # -- declare stage
    output$stage_title <- renderText("Sélection du fichier")
    output$stage_actions <- renderUI(fileInput(inputId = "file_input",
                                               label = "Fichier",
                                               accept = ".csv"))
    
    
    # -------------------------------------
    # Read first line
    # -------------------------------------
    
    observeEvent(input$file_input, {
      
      # -- read file
      header <- read.csv(input$file_input$datapath, header = FALSE, nrows = 1)
      
      # -- declare stage
      output$stage_title <- renderText("En-tête")
      output$stage_actions <- NULL
      
      output$content <- renderTable(header)
      
    })
    
    
    
    # -------------------------------------
    # Read data
    # -------------------------------------
    
    # observeEvent(input$file_input, {
    #   
    #   # -- get values
    #   file <- input$file_input
    #   ext <- tools::file_ext(file$datapath)
    #   
    #   req(file)
    #   validate(need(ext == "csv", "Please upload a csv file"))
    #   
    #   # -- load data
    #   r$dataset <- read.csv(file$datapath, header = TRUE)
    #   
    #   # -- declare stage
    #   output$stage_title <- renderText("Prévisualisation")
    #   output$stage_actions <- NULL
    #   
    #   output$content <- renderTable(head(r$dataset, n = 5))
    #   
    # })
    
    
    # -------------------------------------
    # Read data
    # -------------------------------------
    
    output$data_size <- renderText({
      
      size <- dim(r$dataset)
      paste(size[1], "observations de", size[2], "variables.")
      
      })
    
    
    
  }
)
