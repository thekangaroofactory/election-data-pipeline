

# ------------------------------------------------------------------------------
# Shiny module server logic
# ------------------------------------------------------------------------------

general_result_Server <- function(id, r, path) {
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
    
    output_dm <- readRDS(file = file.path(path$resource, "output_dm.rds"))
    colname_mapping <- readRDS(file = file.path(path$resource, "colname_mapping.rds"))
    drom_mapping <- readRDS(file = file.path(path$resource, "drom_mapping.rds"))
    
    electoral_mapping <- readr::read_delim(file.path(path$resource, "electoral_mapping.csv"), 
                                           delim = ",", escape_double = FALSE, trim_ws = TRUE)
    
    # -------------------------------------
    # Section.1 (rename)
    # -------------------------------------
    
    observeEvent(input$rename_cols, {
      
      cat(module, "Rename cols_before_candidate \n")
      
      # -- get data
      dataset <- r$dataset
      cols_before_candidate <- r$cols_before_candidate
      
      # -- rename columns before candidate (to fit with output data model)
      # update cols_before_candidate
      colnames(dataset)[colnames(dataset) %in% cols_before_candidate] <- rename_cols(cols_before_candidate, output_dm, colname_mapping)
      cols_before_candidate <- colnames(dataset)[1:length(cols_before_candidate)]
      
      # -- store
      r$dataset <- dataset
      r$cols_before_candidate <- cols_before_candidate
      
    })
    
    # -- output
    output$cols_before_candidate <- renderText(r$cols_before_candidate)
    
    
    # -------------------------------------
    # Section.2 (departements)
    # -------------------------------------
    
    observeEvent(input$validate_section_1, {
      
      # -- get values
      dataset <- r$dataset
      cols_before_candidate <- r$cols_before_candidate
      
      # -- cleanup departement & drop nom_departement
      if(all(c("code_departement", "nom_departement") %in% colnames(dataset))){
        
        cat(module, "Code departement \n")
        
        # -- cleanup
        dataset <- cleanup_departement(dataset, drom_mapping, electoral_mapping)
        dataset$'nom_departement' <- NULL
        cols_before_candidate <- cols_before_candidate[!cols_before_candidate %in% 'nom_departement']
        
        # -- output
        output$code_departement <- renderText(unique(dataset$code_departement))
        
        # -- store
        r$dataset <- dataset
        r$cols_before_candidate <- cols_before_candidate
        
      } else
        output$code_departement <- renderText("Pas de colonne département.")
      
    })
    
    
    # -------------------------------------
    # Section.3 (communes)
    # -------------------------------------
    
    observeEvent(input$validate_section_2, {
      
      # -- get values
      dataset <- r$dataset
      
      # -- cleanup commune
      # Note: nom_commune is kept since it's hard to keep an up to date mapping with code_commune
      if(all(c("code_commune", "nom_commune") %in% colnames(dataset))){
        
        # -- cleanup
        dataset <- cleanup_commune(dataset, electoral_mapping)
        
        # -- output
        output$code_commune <- renderText(unique(dataset$code_commune))
        
        # -- store
        r$dataset <- dataset
        
      }
      
    })
    
    
    # -------------------------------------
    # Section.4 (code election)
    # -------------------------------------
    
    observeEvent(input$validate_section_3, {
      
      cat(module, "Code election \n")
      
      # -- get values
      dataset <- r$dataset
      cols_before_candidate <- r$cols_before_candidate
      
      # -- add code election (to the left...)
      dataset <- cbind(data.frame(code_election = rep(paste(r$election_year(), r$election_type(), r$election_turn(), sep = "_"), nrow(dataset))), dataset)
      cols_before_candidate <- c("code_election", cols_before_candidate)
      
      # -- output
      output$code_election <- renderText(unique(dataset$code_election))
      
      # -- store
      r$dataset <- dataset
      r$cols_before_candidate <- cols_before_candidate
      
    })
    
    
  }) # -- end moduleServer
}
