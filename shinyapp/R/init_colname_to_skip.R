

init_colname_to_skip <- function(){
  
  # -- init
  colname_to_skip  <- c("codelocalisation", "libellelocalisation")

  # -- save  
  saveRDS(colname_to_skip, file = file.path(path$resource, "colname_to_skip.rds"))
  
}
