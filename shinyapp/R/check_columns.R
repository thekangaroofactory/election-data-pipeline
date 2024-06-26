

check_columns <- function(data, expected){

  # -- check missing columns  
  cols_missing <- !expected %in% colnames(data)
  
  # -- test
  if(any(cols_missing))
    stop("Missing column(s) in data = ", expected[cols_missing])
  
}
