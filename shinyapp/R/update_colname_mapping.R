

update_colname_mapping <- function(colname_mapping, name, keyword){
  
  # -- create new entry
  new_row <- data.frame(name = name,
                        keyword = keyword)
  
  # -- happend to existing mapping
  colname_mapping <- rbind(colname_mapping, new_row)
  
  # -- save  
  saveRDS(colname_mapping, file = file.path(path$resource, "colname_mapping.rds"))
 
  # -- return
  colname_mapping
   
}
