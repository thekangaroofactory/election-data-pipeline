

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
    
    # -- communication objects
    r$header <- NULL
    r$dataset <- NULL
    r$cols_before_candidate <- NULL
    r$cols_candidate <- NULL
    
    
    # -- launch module servers
    data_manager_Server(id = "data", r, path)
    data_model_Server(id = "dm", r, path)
    general_result_Server(id = "general", r, path)

  }
)
