

rename_cols <- function(cols, dm, mapping){

  # -- flatten column names
  cols <- flatten_string(cols)
  
  # -- check & replace names that already fits with the output data model
  # (typically single word names ex: inscrits, votants)
  cols[cols %in% dm$name] <- dm$name[match(cols[cols %in% dm$name], dm$name)]
  
  # -- check & replace names that fits with an existing entry from the mapping
  cols[cols %in% mapping$keyword] <- mapping$name[match(cols[cols %in% mapping$keyword], mapping$keyword)]

  # -- return
  cols
  
}
