

# ------------------------------------------------------------------------------
# 
# The goal is to fix nom_commune occurences that not fit with their code_commune in electoral_mapping
# 
# ------------------------------------------------------------------------------

#' Suggest nom_commune
#'
#' @param data a data.frame of the rows to be fixed, output of cleanup_commune.R : DEBUG_rows_to_fix
#' @param electoral_mapping a data.frame of the mapping table
#'
#' @return a data.frame of the suggestions
#' @export
#'
#' @examples suggest_nom_commune(data, rows_to_fix)

suggest_nom_commune <- function(data, electoral_mapping){
  
  cat("[suggest_nom_commune] \n")
  
  # -- build search list (remove duplicates)
  search_list <- data[c('code_departement', 'code_commune', 'nom_commune')]
  search_list <- search_list[!duplicated(search_list), ]
  
  # -- helper function to find suggestion
  helper <- function(x){
    
    # -- search suggestion
    select <- electoral_mapping[electoral_mapping$code_departement == x['code_departement'] & electoral_mapping$code_commune == x['code_commune'], ]
    
    # -- build dummy object in case search has no result (otherwise an error will be raised at next line)
    if(nrow(select) == 0)
      select <- data.frame(code_departement = NA,
                           nom_commune = NA,
                           code_commune = NA)
    
    # -- build output
    data.frame(code_departement = select$code_departement,
               code_commune = x['code_commune'],
               dataset_nom_commune = x['nom_commune'],
               mapping_nom_commune = select$nom_commune)
    
  }
  
  # -- apply helper & return simplified result
  res <- apply(search_list, 1, helper)
  data.table::rbindlist(res)
  
}
