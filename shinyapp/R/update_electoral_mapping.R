

# ------------------------------------------------------------------------------
# Des communes peuvent être ajoutées (ou supprimées) entre deux élections
# Exemple: Sannerville dans le Calvados disparaît en 2017 (fusion dans une nouvelle commune Saline) 
# puis revient en 2020 après séparation de Saline
# Le but est d'avoir le maximum de mapping pour retrouver les contours (donc Sannerville et Saline)
# ------------------------------------------------------------------------------



# res <- lapply(foo$code_commune, function(x) search_commune(code = x))
# res <- data.table::rbindlist(res, fill = TRUE)
# 
# foo$api_nom_commune <- res[match(foo$code_commune, res$code), ]$nom

# 
# electoral_mapping <- update_electoral_mapping(electoral_mapping,
#                                               numero_departement = "ZZ",
#                                               code_departement = "ZZ",
#                                               nom_departement = "Français établis hors de France",
#                                               numero_commune = 238,
#                                               code_commune = "ZZ238",
#                                               nom_commune = "Florence",
#                                               code_circonscription = 8,
#                                               code_canton = 1,
#                                               nom_canton = "Canton fictif")
# 
# write.csv(electoral_mapping,
#           file = "E:/Portfolio/R/Projects/election-data-pipeline/shinyapp/src/electoral_mapping.csv",
#           row.names = FALSE,
#           fileEncoding = "UTF-8")




update_electoral_mapping <- function(electoral_mapping,
                                     numero_departement,
                                     code_departement,
                                     nom_departement,
                                     numero_commune,
                                     code_commune,
                                     nom_commune,
                                     code_circonscription,
                                     code_canton,
                                     nom_canton){
  
  # -- create new entry
  df <- data.frame("numero_departement" = numero_departement,
                   "code_departement" = code_departement,
                   "nom_departement" = nom_departement,
                   "numero_commune" = numero_commune,
                   "code_commune" = code_commune,
                   "nom_commune" = nom_commune,
                   "code_circonscription" = code_circonscription,
                   "code_canton" = code_canton,
                   "nom_canton" = nom_canton)
  
  # -- merge & return
  rbind(electoral_mapping, df)
  
}
