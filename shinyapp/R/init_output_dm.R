

init_output_dm <- function(){
  
  # -- names
  name = c("code_departement", "nom_departement", 
           "code_commune", "nom_commune",
           "code_circonscription",
           "code_canton", "nom_canton",
           "code_bureau_vote",
           "code_liste",
           "nom_liste", "nom_liste_etendu",
           "nom_candidat",
           "nuance",
           "voix",
           "inscrits",
           "abstentions",
           "votants",
           "blancs",
           "nuls",
           "exprimes")
  
  # -- types
  type = c("character", "character", 
           "character", "character",
           "character", 
           "character", "character",
           "character",
           "integer",
           "character", "character",
           "character",
           "character",
           "integer",
           "integer",
           "integer",
           "integer",
           "integer",
           "integer",
           "integer")
  
  # -- lengths
  length <- c(2, NA, 
              3, NA,
              2,
              2, NA,
              NA,
              NA,
              NA, NA,
              NA,
              NA,
              NA,
              NA,
              NA,
              NA,
              NA,
              NA,
              NA)
  
  # -- create df
  output_dm <- data.frame(name = name, type = type, length = length)
  
  # -- save  
  saveRDS(output_dm, file = file.path(path$resource, "output_dm.rds"))
  
}