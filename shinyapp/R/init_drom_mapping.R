

init_drom_mapping <- function(){
  
  # -- define names
  drom_name <- c("Guadeloupe", "Martinique", "Guyane", "La Réunion", "Saint-Pierre-et-Miquelon", "Mayotte", "Saint-Barthélemy",
                 "Saint-Martin", "Wallis et Futuna","Polynésie française", "Nouvelle-Calédonie")
  
  # -- define number
  drom_nb <- c(971, 972, 973, 974, 975, 976, 977,
               978, 986, 987, 988)
  
  # -- define code
  drom_code <- c("ZA", "ZB", "ZC", "ZD", "ZS", "ZM", "ZX",
                 "ZX", "ZW", "ZP", "ZN")
  
  # -- merge
  drom_mapping <- data.frame(name = drom_name,
                             nb = drom_nb,
                             code = drom_code)
  
  # -- save  
  saveRDS(drom_mapping, file = file.path(path$resource, "drom_mapping.rds"))

}