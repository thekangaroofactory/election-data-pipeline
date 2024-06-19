

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
    menuItem("Home", tabName = "home", icon = icon("home"), selected = TRUE)))


# -- Define the body
cat("-- Define body \n")
body <- dashboardBody(
  tabItems(
    
    # -- Home
    tabItem(tabName = "home",
            
            # -- standard text
            h2("Home"),
            p("This is a template app."))
    
  ) # tabItems
) # dashboardBody


# -- Put them together into a dashboard
cat("-- Put them together \n")
cat("-------------------------------------------------- \n")

dashboardPage(
  header,
  sidebar,
  body)
