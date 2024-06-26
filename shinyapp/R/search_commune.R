

search_commune <- function(departement = NULL, code = NULL, nom = NULL){
  
  # -- build request
  request <- "https://geo.api.gouv.fr/communes?"
  
  if(!is.null(code))
    request <- paste0(request, "code=", code)
    
  else
    request <- paste0(request, "nom=", nom, "&codeDepartement=", departement)
  
  # -- open connection, make request, close connection
  con <- curl::curl(request)
  res <- readLines(con, warn = FALSE)
  close(con)
  
  # -- return NULL or as a data.frame
  if(res == "[]")
    NULL
  else
    jsonlite::fromJSON(res)
  
}
