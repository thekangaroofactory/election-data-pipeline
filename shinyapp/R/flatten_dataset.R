

flatten_dataset <- function(data, cols_before, cols_candidate, nb_cand){

  # -- get values
  nb_cols_before <- length(cols_before)
  nb_cols_cand <- length(cols_candidate)
  
  # -- helper function
  helper <- function(x){
    
    cat("-- Processing candidate #", x, "\n")
    
    # -- compute cols index
    start <- nb_cols_before + 1 + (x - 1) * nb_cols_cand
    end <- nb_cols_before + x * nb_cols_cand
    
    # -- define cols to keep
    cols_to_keep <- c(1:nb_cols_before, c(start:end))
    
    # -- subset
    data[cols_to_keep]
    
  }
  
  # -- apply helper and bind result
  res <- lapply(1:nb_cand, function(x) helper(x))
  data <- as.data.frame(data.table::rbindlist(res, use.names = FALSE))
  
  # -- clean rows with only NA values (because some elections have different amount of candidates per row!)
  #if(pattern == "Legislatives")
  #  data <- data[!is.na(data$V.22), ]
  
  # -- set col names
  #colnames(data) <- c(names(cols_before), names(cols_candidate))
  
  # return
  data
  
}
