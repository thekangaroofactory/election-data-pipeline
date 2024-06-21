
cat("-------------------------------------------------- \n")
cat("Setting global environment: \n")

# ------------------------------------------------------------------------------
# Attach dependencies
# ------------------------------------------------------------------------------

cat("-- Attach dependencies \n")

library(shiny)
library(shinydashboard)


# ------------------------------------------------------------------------------
# Define parameters
# ------------------------------------------------------------------------------

cat("-- Declare global parameters \n")

# -- Declare path
path <- list(script = "./R",
             resource = "./src",
             data = "../data")


# ------------------------------------------------------------------------------
# Init environment
# ------------------------------------------------------------------------------

cat("-- Init environment \n")

# -- Load scripts
for (nm in list.files(path$script, full.names = TRUE, recursive = TRUE, include.dirs = FALSE))
{
  cat("Loading code from: ", nm, "\n")
  source(nm)
}
rm(nm)


cat("-------------------------------------------------- \n")
