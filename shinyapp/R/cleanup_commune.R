

cleanup_commune <- function(data, electoral_mapping){
  
  cat("[cleanup_commune] \n")
  
  # -- check if colnames exists
  expected_cols <- c("code_commune", "nom_commune")
  check_columns(data, expected_cols)
  
  # ----------------------------------------------------------------------------
  # Treatment by territory since it's hard to generalize for DROM / COM
  # code_departement have already been fixed so we expect to find ZA.. ZZ (not 971, 972...)
  # ----------------------------------------------------------------------------
  
  # -------------------------------------
  # General case
  # -------------------------------------
  # code_departement from '01' to '95' + '2A' + '2B'
  # code_commune = code_departement (2 digits, ex: '01') + num commune (3 digits, ex: '001')
  # example: 01001, 94018
  
  # -- generate sequence to subset data
  sequence <- stringr::str_pad(as.character(1:95), width = 2, pad = "0")
  sequence <- c(sequence, "2A", "2B")
  
  # -- identify rows to fix (with length different from 5 digits)
  rows_to_fix <- nchar(unique(data[data$code_departement %in% sequence, ]$code_commune)) != 5
  cat("-- Check general case \n")

  
  if(any(rows_to_fix)){
  
    cat("-- Fixing code_commune (general case), occurence =", sum(rows_to_fix), "\n")  
    
    # ****************************************************************************************************************************
    # >> prendre un fichier qui a le problème
    # ****************************************************************************************************************************
  
  }
  
  
  # -------------------------------------
  # Guadeloupe, Martinique, Guyane, La Réunion, 
  # Saint-Pierre-et-Miquelon, Mayotte
  # -------------------------------------
  # code_departement = ZA, ZB, ZC, ZD, ZS, ZM
  # code_commune = code_departement (3 digits, ex: '971') + num commune (2 digits, ex: '01')
  # example: 97101, 97234, 97304, 97415, 97501, 97610
  
  # -- generate sequence to subset data
  sequence <- c("ZA", "ZB", "ZC", "ZD", "ZS", "ZM")
  
  # -- identify rows to fix (with length different from 5 digits)
  rows_to_fix <- nchar(unique(data[data$code_departement %in% sequence, ]$code_commune)) != 5
  cat("-- Check Guadeloupe, Martinique, Guyane, La Réunion, Saint-Pierre-et-Miquelon, Mayotte \n")
  
  
  if(any(rows_to_fix)){
    
    cat("-- Fixing code_commune (case Guadeloupe), occurence =", sum(rows_to_fix), "\n")  
    
    # ****************************************************************************************************************************
    # >> prendre un fichier qui a le problème
    # ****************************************************************************************************************************
    
  }
  
  
  # -------------------------------------
  # Wallis-et-Futuna
  # -------------------------------------
  # code_departement = ZW
  # code_commune = 98601 (single commune for the whole territory)
  
  # -- generate sequence to subset data
  sequence <- c("ZW")
  
  # -- identify rows to fix (with length different from 5 digits)
  rows_to_fix <- nchar(unique(data[data$code_departement %in% sequence, ]$code_commune)) != 5
  cat("-- Check Wallis-et-Futuna \n")
  
  
  if(any(rows_to_fix)){
    
    cat("-- Fixing code_commune (case Wallis-et-Futuna), occurence =", sum(rows_to_fix), "\n")  
    
    # ****************************************************************************************************************************
    # >> prendre un fichier qui a le problème
    # ****************************************************************************************************************************
    
    # >> forcer le code à 98601
    
  }
  
  
  # -------------------------------------
  # Polynésie française
  # -------------------------------------
  # code_departement = ZP
  # code_commune = code_departement (3 digits, ex: '987') + num commune (2 digits, ex: '40')
  # example: Rangiroa = 98740
  
  # -- generate sequence to subset data
  sequence <- c("ZP")
  
  # -- identify rows to fix (with length different from 5 digits)
  rows_to_fix <- nchar(unique(data[data$code_departement %in% sequence, ]$code_commune)) != 5
  cat("-- Check Polynésie française \n")
  
  
  if(any(rows_to_fix)){
    
    cat("-- Fixing code_commune (case Polynésie française), occurence =", sum(rows_to_fix), "\n")  
    
    # ****************************************************************************************************************************
    # >> prendre un fichier qui a le problème
    # ****************************************************************************************************************************
    
  }
  
  
  # -------------------------------------
  # Saint-Barthélemy, Saint-Martin
  # -------------------------------------
  # code_departement = ZX
  # code_commune = code_departement (2 digits, ex: 'ZX') + num commune (3 digits, ex: '701')
  # example: Saint-Barthélemy = ZX701, Saint-Martin = ZX801
  
  # -- generate sequence to subset data
  sequence <- c("ZX")
  
  # -- identify rows to fix (with length different from 5 digits)
  rows_to_fix <- nchar(unique(data[data$code_departement %in% sequence, ]$code_commune)) != 5
  cat("-- Check Saint-Barthélemy, Saint-Martin \n")
  
  
  if(any(rows_to_fix)){
    
    cat("-- Fixing code_commune (case Saint-Barthélemy, Saint-Martin), occurence =", sum(rows_to_fix), "\n")  
    
    # ****************************************************************************************************************************
    # >> prendre un fichier qui a le problème
    # ****************************************************************************************************************************
    
  }
  
  
  # -------------------------------------
  # Français établis hors de France
  # -------------------------------------
  # code_departement = ZZ
  # code_commune = code_departement (2 digits, ex: 'ZZ') + num commune (3 digits, ex: '201')
  # example: Sydney = ZZ201, Chicago = ZZ051
  
  # -- generate sequence to subset data
  sequence <- c("ZZ")
  
  # -- identify rows to fix (with length different from 5 digits)
  rows_to_fix <- nchar(unique(data[data$code_departement %in% sequence, ]$code_commune)) != 5
  cat("-- Check Français établis hors de France \n")
  
  
  if(any(rows_to_fix)){
    
    cat("-- Fixing code_commune (case Français établis hors de France), occurence =", sum(rows_to_fix), "\n")  
    
    # ****************************************************************************************************************************
    # >> prendre un fichier qui a le problème
    # ****************************************************************************************************************************
    
  }
  
  
  # ----------------------------------------------------------------------------
  # Check that code_commune exists in electoral_mapping
  # ----------------------------------------------------------------------------
  
  # -- identify rows to fix (with code_commune not in electoral_mapping)
  rows_to_fix <- !data$code_commune %in% electoral_mapping$code_commune
  cat("-- Check code_commune in electoral_mapping \n")
  
  
  if(any(rows_to_fix)){
    
    cat("[WARNING] Some code_commune are not found in electoral_mapping reference table! \n")
    DEBUG_rows_to_fix <<- data[rows_to_fix, ]
    stop("Fix corresponding rows using suggest_code_commune(DEBUG_rows_to_fix, electoral_mapping) & relaunch script")
    
  }
  
  cat("All checks done. \n")
  
  # -- return
  data
  
}
