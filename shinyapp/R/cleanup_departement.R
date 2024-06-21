

cleanup_departement <- function(data, drom_mapping, electoral_mapping){
  
  # -- cleanup DROM/COM numbers
  data <- check_drom_code(data, colname = "code_departement", drom_mapping)
  
  # -- cleanup single digit numbers
  rows_to_fix <- nchar(data[["code_departement"]]) > 2
  
  if(any(rows_to_fix)){
    
    cat("-- Fixing single digit code, occurences =", sum(rows_to_fix), "\n")
    data[rows_to_fix, "code_departement"] <- stringr::str_pad(data[rows_to_fix, "code_departement"], width = 2)
    
  }
  
  # -- check that all nom_departement match with reference table
  rows_to_fix <- !data$'nom_departement' %in% electoral_mapping$'nom_departement'
  
  if(any(rows_to_fix)){
    
    cat("[WARNING] Some nom_departement names do not fit with reference table! \n")
    DEBUG_rows_to_fix <<- data[rows_to_fix, ]
    stop("Fix corresponding rows in DEBUG_rows_to_fix & relaunch script")
    
  }
  
  # -- check that all code_departement match with reference table (based on nom_departement)
  rows_to_fix <- electoral_mapping[match(data$'nom_departement', electoral_mapping$'nom_departement'), 'code_departement'] != data$'code_departement'
  
  if(any(rows_to_fix)){
    
    cat("[WARNING] Some code_departement do not fit with corresponding nom_departement in the reference table! \n")
    DEBUG_rows_to_fix <<- data[rows_to_fix, ]
    stop("Fix corresponding rows in DEBUG_rows_to_fix & relaunch script")
    
  }
  
  # -- return
  data
  
}