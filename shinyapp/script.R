

# -------------------------------------
# Notes
# 
# - on garde les noms de commune car ils ne sont pas fiables dans la durée donc difficile
# de maintenir un mapping dans ce but.



# ******************************************************************************
# 
# Créer un module dédié pour la mise à jour du mapping électoral
# - vérifier les noms des communes vs code_commune
# - prévoir un formulaire d'ajout de nouvelles communes (résultat API + champs manuels circo & canton)
# 
# ******************************************************************************


# -------------------------------------
# Parameters
# -------------------------------------

# -- file
datapath <- "D:/Downloads/resultats-definitifs-par-bureau-de-vote.csv"

# -- options
sep = ";"
fileEncoding = "UTF-8"

cols_candidate_string <- "panneau"


# -------------------------------------
# Load resources
# -------------------------------------

# *****************************************************************************************************************
path <- list(script = "./shinyapp/R",
             resource = "./shinyapp/src")

# -- Load scripts
for (nm in list.files(path$script, full.names = TRUE, recursive = TRUE, include.dirs = FALSE))
{
  cat("Loading code from: ", nm, "\n")
  source(nm)
}
rm(nm)


# *****************************************************************************************************************

# -- resources
output_dm <- readRDS(file = file.path(path$resource, "output_dm.rds"))
colname_mapping <- readRDS(file = file.path(path$resource, "colname_mapping.rds"))
colname_to_skip <- readRDS(file = file.path(path$resource, "colname_to_skip.rds"))
drom_mapping <- readRDS(file = file.path(path$resource, "drom_mapping.rds"))

# *****************************************************************************************************************
electoral_mapping <- readr::read_delim("shinyapp/src/electoral_mapping.csv", 
                                       delim = ",", escape_double = FALSE, trim_ws = TRUE)
# *****************************************************************************************************************


# -------------------------------------
# Headers
# -------------------------------------

# -- read first line
header <- read.csv(datapath, header = TRUE, nrows = 10, sep = sep, fileEncoding = fileEncoding)

# -- get col names
raw_colnames <- colnames(header)

# -- find candidate first col & col number
# Those columns need to be renamed after the rows are flatten
# at this stage, we need the index of the first column, and the number of columns
cols_candidate_idx <- grep(cols_candidate_string, colnames(header))
cols_candidate_nb <- cols_candidate_idx[2] - cols_candidate_idx[1]

# -- number of candidates
nb_candidate <- length(cols_candidate_idx)

# -- cols before candidate
cols_before_candidate <- raw_colnames[1:cols_candidate_idx[1]-1]

# -- cols candidate
cols_candidate <- raw_colnames[cols_candidate_idx[1]:(cols_candidate_idx[2]-1)]


# -------------------------------------
# Data model (before candidate)
# -------------------------------------

# -- create data.frame (before_candidate)
dm_before_candidate <- data.frame(name = cols_before_candidate)
dm_before_candidate$type <- unlist(lapply(header[cols_before_candidate], class))

# -- colnames with 'code' are detected as integer while it could contain string
# fix before skipping cols otherwise it would overwrite "NULL"
dm_before_candidate[grep("code", flatten_string(dm_before_candidate$name)), ]$type <- "character"

# -- cols to skip (before_candidate)
# columns starting with 'X' (as a replacement for % in the file)
dm_before_candidate[grep("X..", dm_before_candidate$name), ]$type <- "NULL"

# -- cols to skip (before_candidate)
# columns with name in exclusion list
dm_before_candidate[flatten_string(dm_before_candidate$name) %in% colname_to_skip, ]$type <- "NULL"


# -------------------------------------
# Data model (candidate)
# -------------------------------------

# -- create data.frame (candidate)
dm_candidate <- data.frame(name = cols_candidate)
dm_candidate$type <- unlist(lapply(header[cols_candidate], class))

# -- cols to skip (candidate)
# columns starting with 'X' (as a replacement for % in the file)
dm_candidate[grep("X..", dm_candidate$name), ]$type <- "NULL"


# -------------------------------------
# Read the data
# -------------------------------------

# -- prepare colClasses (before candidate)
colClasses_before_candidate <- dm_before_candidate$type

# -- prepare colClasses (candidate)
colClasses_candidate <- dm_candidate$type

# -- merge colClasses
colClasses <- c(colClasses_before_candidate, rep(colClasses_candidate, nb_candidate))

# -- read file
dataset <- read.csv(datapath, header = TRUE, sep = sep, fileEncoding = fileEncoding,
                    colClasses = colClasses)

# -- update cols (since some of them are not loaded)
cols_before_candidate <- dm_before_candidate[dm_before_candidate$type != "NULL", ]$name
cols_candidate <- dm_candidate[dm_candidate$type != "NULL", ]$name


# -------------------------------------
# Check & cleanup general results
# -------------------------------------

# Before performing row flattening & general result extract, it is needed to cleanup
# the general result columns

# -- rename columns before candidate (to fit with output data model)
colnames(dataset)[colnames(dataset) %in% cols_before_candidate] <- rename_cols(cols_before_candidate, output_dm, colname_mapping)

# -- cleanup departement & drop nom_departement
dataset <- cleanup_departement(dataset, drom_mapping, electoral_mapping)
dataset$'nom_departement' <- NULL

# -- cleanup commune
# Note: nom_commune is kept since it's hard to keep an up to date mapping with code_commune
dataset <- cleanup_commune(dataset, electoral_mapping)


# ********************************************************
# 
# Ajouter le code_election, puis
# 
# extraire le résultat général (inscrits, participation, ...) avant de faire le flatten
# en conservant les cols code dep, commune, bv
#
# construire la liste des candidats
# panneau, nuance, nom liste abrg, nom liste étendue
#
# ********************************************************
  
# -------------------------------------
# Flatten the data
# -------------------------------------



foo <- flatten_dataset(dataset, 
                       cols_before = cols_before_candidate,
                       cols_candidate = cols_candidate,
                       nb_cand = nb_candidate)

