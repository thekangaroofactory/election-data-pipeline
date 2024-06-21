

check_drom_code <- function(data, colname, drom_mapping){
  
  # -- check if any row has length > 2 (ex: 972, 973...)
  isDirty <- any(nchar(unique(data[[colname]])) > 2)
  cat("-- Check DROM/COM code / cleanup needed =", isDirty, "\n")

  # -- cleanup
  if(isDirty)
    data[nchar(data[[colname]]) > 2, colname] <- drom_mapping[match(data[nchar(data[[colname]]) > 2, colname], drom_mapping$nb), ]$code
  
  # -- return
  data
  
}
