

# ------------------------------------------------------------------------------
# User-interface definition of the Shiny web application
# ------------------------------------------------------------------------------

cat("-------------------------------------------------- \n")
cat("Building application user interface: \n")

# -- Define the header
cat("-- Define header \n")
header <- dashboardHeader(title = "election-data-pipeline")


# -- Define the Sidebar
cat("-- Define sidebar \n")
sidebar <- dashboardSidebar(
  
  # -- static section
  sidebarMenu(
    menuItem("Dataset", tabName = "dataset", icon = icon("home"), selected = TRUE),
    menuItem("Data model", tabName = "header", icon = icon("home")),
    menuItem("Résultat général", tabName = "general", icon = icon("home"))))


# -- Define the body
cat("-- Define body \n")
body <- dashboardBody(
  tabItems(
    
    # -- dataset
    tabItem(tabName = "dataset",
            
            # -- title
            h2("Sélection du fichier"),
            
            # -- inputs
            election_type_UI("data"),
            file_options_UI("data"),
            file_input_UI("data"),
            
            # -- preview
            content_preview_UI("data")),
    
    
    # -- header
    tabItem(tabName = "header",
            
            # -- title
            h2("Préparation"),
            
            # -- section.1
            raw_colnames_UI("dm"),
            
            # -- section.2
            nb_candidate_UI("dm"),
            
            # -- section.3
            dm_before_candidate_UI("dm"),
            
            # -- section.4
            dm_candidate_UI("dm"),
            
            # -- section.5
            dataset_preview_UI("dm")),
    
    
    # -- general
    tabItem(tabName = "general",
     
            # -- title
            h2("Résultat Général"),
            
            # -- section.1
            rename_colnames_UI("general"),
            
            # -- section.2
            departement_UI("general"),
            
            # -- section.3
            commune_UI("general"),
            
            # -- section.4
            code_election_UI("general")
                   
    )
    
    
  ) # tabItems
) # dashboardBody


# -- Put them together into a dashboard
cat("-- Put them together \n")
cat("-------------------------------------------------- \n")

dashboardPage(
  header,
  sidebar,
  body)
