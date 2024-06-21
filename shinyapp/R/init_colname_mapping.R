

init_colname_mapping <- function(){
  
  # -- init colname mapping
  colname_mapping <- data.frame(name = output_dm$name,
                                keyword = flatten_string(output_dm$name))
  
  # -- remove duplicates
  colname_mapping <- colname_mapping[colname_mapping$name != colname_mapping$keyword, ]
  

  # -- save  
  saveRDS(colname_mapping, file = file.path(path$resource, "colname_mapping.rds"))
  
}
