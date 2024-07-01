

# -- section.1
rename_colnames_UI  <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- output
  wellPanel(
    
    h4("Section.1 (Colonnes avant candidats)"),
    p("Renommer les colonnes pour correspondre au format de sortie:"), 
    actionButton(inputId = ns("rename_cols"),
                 label = "Renommer"),
    
    br(), p("Colonnes avant candidats:"),
    verbatimTextOutput(ns("cols_before_candidate")),
    
    actionButton(inputId = ns("validate_section_1"),
                 label = "Valider"))
  
}


# -- section.2
departement_UI  <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- output
  wellPanel(
    
    h4("Section.2 (Colonnes département)"),
    p("Les codes départements 972, 973, etc. sont remplacés par ZA, ZB, etc."),
    
    p("Codes départements :"),
    verbatimTextOutput(ns("code_departement")),
    
    actionButton(inputId = ns("validate_section_2"),
                 label = "Valider"))
  
}


# -- section.3
commune_UI  <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- output
  wellPanel(
    
    h4("Section.3 (Colonnes communes)"),
    p("On recherche les codes communes qui n'existent pas dans le mapping électoral."),
    
    p("Codes commune :"),
    verbatimTextOutput(ns("code_commune")),
    
    actionButton(inputId = ns("validate_section_3"),
                 label = "Valider"))
  
}


# -- section.4
code_election_UI  <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- output
  wellPanel(
    
    h4("Section.4 (Code election)"),
    p("On ajoute la colonne code_election:"),
    
    verbatimTextOutput(ns("code_election")),
    
    actionButton(inputId = ns("validate_section_4"),
                 label = "Valider"))
  
}

