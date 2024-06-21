

cleanup_commune <- function(data){
  
  # -- treatment by territory since it's hard to generalize for DROM / COM
  # code_departement have already been fixed so we expect to find ZA.. ZZ (not 971, 972...)
  
  # -- general case
  # (code_departement from '01' to '95')
  
  # -- generate sequence to subset data
  sequence <- stringr::str_pad(as.character(1:95), width = 2, pad = "0")
  
  # -- identify rows to fix (with length different from 5 digits)
  rows_to_fix <- nchar(unique(data[data$code_departement %in% sequence, ]$code_commune)) != 5

  
  if(any(rows_to_fix)){
  
    cat("-- Fixing code_commune (general case), occurence =", sum(rows_to_fix), "\n")  
    
    # ****************************************************************************************************************************
    # >> prendre un fichier qui a le problème
    # ****************************************************************************************************************************
  
  }
  
  # -- Guadeloupe
  # code_departement = ZA
  
  # -- identify rows to fix (with length different from 5 digits)
  rows_to_fix <- nchar(unique(data[data$code_departement == "ZA", ]$code_commune)) != 5
  
  if(any(rows_to_fix)){
    
    cat("-- Fixing code_commune (case Guadeloupe), occurence =", sum(rows_to_fix), "\n")  
    
    # ****************************************************************************************************************************
    # >> prendre un fichier qui a le problème
    # ****************************************************************************************************************************
    
  }
  
  
  
}