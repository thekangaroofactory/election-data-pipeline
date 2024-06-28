
# -- select file
file_input_UI <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- input
  fileInput(inputId = ns("file_input"),
            label = "Fichier",
            accept = ".csv")
  
}

file_options_UI <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- input
  fluidRow(
    
    column(width = 4, 
           # -- separator
           radioButtons(inputId = ns("file_separator"),
                        label = "Séparateur",
                        choices = c("Virgule" = ",",
                                    "Point-virgule" = ";"))),
    
    column(width = 4, 
           # -- encoding
           radioButtons(inputId = ns("file_encoding"),
                        label = "Encoding",
                        choices = c("UTF-8", "ANSI"))))
  
}

# -- select election type
election_type_UI <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  fluidRow(
    
    column(width = 4, 
           # -- year
           numericInput(inputId = ns("election_year"),
                        label = "Année",
                        value = as.numeric(format(Sys.Date(), "%Y")),
                        min = 2017,
                        max = as.numeric(format(Sys.Date(), "%Y")))),
    
    column(width = 4, 
           # -- input
           radioButtons(inputId = ns("election_type"),
                        label = "Election",
                        choices = c("Présidentielle" = "PDT",
                                    "Législative" = "LEG",
                                    "Européenne" = "EUR"))),
    
    column(width = 4, 
           # -- turn
           radioButtons(inputId = ns("election_turn"),
                        label = "Tour",
                        choices = c("1er tour" = "T1",
                                    "2ème tour" = "T2"))))
  
}


content_preview_UI <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- input
  tableOutput(ns("content_preview"))
  
}
