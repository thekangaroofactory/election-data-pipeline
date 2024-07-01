

# ------------------------------------------------------------------------------
# Shiny module server logic
# ------------------------------------------------------------------------------

data_model_Server <- function(id, r, path) {
  moduleServer(id, function(input, output, session) {
    
    # -------------------------------------
    # Config
    # -------------------------------------
    
    # -- get namespace
    ns <- session$ns
    
    # -- parameters
    module <- paste0("[", id, "]")
    
    
    # -------------------------------------
    # Resources
    # -------------------------------------
    
    colname_to_skip <- readRDS(file = file.path(path$resource, "colname_to_skip.rds"))
    
    
    # -------------------------------------
    # Section.1
    # -------------------------------------
    
    # -- nb columns
    output$nb_columns <- renderText(dim(r$header())[2])
    
    # -- raw colnames
    raw_colnames <- reactive(colnames(r$header()))
    output$raw_colnames <- renderText(paste(raw_colnames(), collapse = ", "))
    
    
    # -------------------------------------
    # Section.2
    # -------------------------------------
    
    # -- find candidate first col & col number
    # Those columns need to be renamed after the rows are flatten
    # at this stage, we need the index of the first column, and the number of columns
    cols_candidate_idx <- reactive(grep(input$candidate_string, raw_colnames()))
    
    # -- number of candidates
    r$nb_candidate <- reactive(length(cols_candidate_idx()))
    output$nb_candidate <- renderValueBox(valueBox(value = r$nb_candidate(),
                                                   "Nombre de candidats / listes"))
    
    # -- cols before candidate
    cols_before_candidate <- reactive(raw_colnames()[1:cols_candidate_idx()[1]-1])
    output$cols_before_candidate <- renderText(cols_before_candidate())
    
    # -- cols candidate
    cols_candidate <- reactive(raw_colnames()[cols_candidate_idx()[1]:(cols_candidate_idx()[2]-1)])
    output$cols_candidate <- renderText(cols_candidate())
    
    
    # -------------------------------------
    # Section.3
    # -------------------------------------
    # Data model (before candidate)
    
    observeEvent(input$validate_section_2, {
      
      cat(module, "Data model (before candidate) \n")
      
      # -- create data.frame (before_candidate)
      dm_before_candidate <- data.frame(name = cols_before_candidate())
      dm_before_candidate$type <- unlist(lapply(r$header()[cols_before_candidate()], class))
      
      # -- colnames with 'code' are detected as integer while it could contain string
      # fix before skipping cols otherwise it would overwrite "NULL"
      dm_before_candidate[grep("code", flatten_string(dm_before_candidate$name)), ]$type <- "character"
      
      # -- cols to skip (before_candidate)
      # columns starting with 'X' (as a replacement for % in the file)
      dm_before_candidate[grep("X..", dm_before_candidate$name), ]$type <- "NULL"
      
      # -- cols to skip (before_candidate)
      # columns with name in exclusion list
      dm_before_candidate[flatten_string(dm_before_candidate$name) %in% colname_to_skip, ]$type <- "NULL"
      
      # -- output & store
      output$dm_before_candidate <- DT::renderDT(dm_before_candidate)
      r$dm_before_candidate <- dm_before_candidate
      
    })
    
    
    # -------------------------------------
    # Section.4
    # -------------------------------------
    # Data model (candidate)
    
    observeEvent(input$validate_section_3, {
      
      cat(module, "Data model (candidate) \n")
      
      # -- create data.frame (candidate)
      dm_candidate <- data.frame(name = cols_candidate())
      dm_candidate$type <- unlist(lapply(r$header()[cols_candidate()], class))
      
      # -- cols to skip (candidate)
      # columns starting with 'X' (as a replacement for % in the file)
      dm_candidate[grep("X..", dm_candidate$name), ]$type <- "NULL"
    
      # -- output & store
      output$dm_candidate <- DT::renderDT(dm_candidate)
      r$dm_candidate <- dm_candidate
    
    })
    
    
    # -------------------------------------
    # Section.5
    # -------------------------------------
    # Read the data
    
    observeEvent(input$validate_section_4, {
      
      cat(module, "Prepare to read the data \n")
      
      # -- get values
      dm_before_candidate <- r$dm_before_candidate
      dm_candidate <- r$dm_candidate
      nb_candidate <- r$nb_candidate()
        
      # -- prepare colClasses (before candidate)
      colClasses_before_candidate <- dm_before_candidate$type

      # -- prepare colClasses (candidate)
      colClasses_candidate <- dm_candidate$type

      # -- merge colClasses
      colClasses <- c(colClasses_before_candidate, rep(colClasses_candidate, nb_candidate))

      # -- read file
      cat(module, "Reading the data... \n")
      dataset <- read.csv(r$datapath(),
                          header = TRUE,
                          sep = r$file_separator(),
                          fileEncoding = r$file_encoding(),
                          colClasses = colClasses)
      cat(module, "-- Done. \n")

      
      # -- update cols (since some of them are not loaded)
      cols_before_candidate <- dm_before_candidate[dm_before_candidate$type != "NULL", ]$name
      cols_candidate <- dm_candidate[dm_candidate$type != "NULL", ]$name

      # -- output
      output$dataset_preview <- DT::renderDT(head(dataset, n = 5))
      
      # -- store
      r$dataset <- dataset
      
    })
    
    
  }) # -- end moduleServer
}
