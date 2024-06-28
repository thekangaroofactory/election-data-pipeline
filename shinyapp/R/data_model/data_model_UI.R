

# -- section.1
raw_colnames_UI  <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- output
  wellPanel(
    
    h4("Section.1 - Colonnes (noms bruts)"),
    p("Nombre de colonnes du fichier brut:", textOutput(ns("nb_columns"), inline = TRUE)),
    verbatimTextOutput(ns("raw_colnames")))
  
}


# -- section.2
nb_candidate_UI <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- input
  wellPanel(
    
    h4("Section.2 - Première colonne candidat"),
    
    textInput(inputId = ns("candidate_string"),
              label = "Pattern",
              value = "panneau",
              width = '25%'),
    
    fluidRow(
      valueBoxOutput(ns("nb_candidate"))),
    
    fluidRow(
      column(width = 6, 
             strong("cols_before_candidate"),
             verbatimTextOutput(ns("cols_before_candidate"))),
      column(width = 6, 
             strong("cols_candidate"),
             verbatimTextOutput(ns("cols_candidate")))),
    
    actionButton(inputId = ns("validate_section_2"),
                 label = "Confirmer"))
  
}


# -- section.3
dm_before_candidate_UI <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- input
  wellPanel(
    
    h4("Section.3 - Colonnes avant candidats"),
    p("La liste des colonnes avant les colonnes candidats est la suivante (avec les classes à utiliser pour le chargement)"),
    
    DT::DTOutput(ns("dm_before_candidate")),
    
    actionButton(inputId = ns("validate_section_3"),
                 label = "Confirmer"))
  
}


# -- section.4
dm_candidate_UI <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- input
  wellPanel(
    
    h4("Section.4 - Colonnes candidats"),
    p("Liste des colonnes candidats (avec les classes à utiliser pour le chargement)"),
    
    DT::DTOutput(ns("dm_candidate")),
    
    actionButton(inputId = ns("validate_section_4"),
                 label = "Confirmer"))
  
}


# -- section.5
dataset_preview_UI <- function(id){
  
  # -- namespace
  ns <- NS(id)
  
  # -- input
  wellPanel(
    
    h4("Section.5 - Preview"),

    DT::DTOutput(ns("dataset_preview")))
  
}



