

#' Flatten string
#'
#' @param x a character vector
#'
#' @return a character vector
#' @export
#'
#' @examples flatten_string("Ce_Chêne-liège.déprimé")

flatten_string <- function(x){
  
  # -- remove capital letters
  x <- tolower(x)
  
  # -- remove accents
  x <- iconv(x , from = "UTF-8", to = 'ASCII//TRANSLIT')
  
  # -- remove dots, underscores, dashes
  x <- gsub('\\.', '', x)
  x <- gsub('\\_', '', x)
  gsub('\\-', '', x)
  
}
