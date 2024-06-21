

# -- table_attributs

code_departement, character, 2
nom_departement, character
code_commune, character, 3
nom_commune, character
code_circonscription, character, 2
code_canton, character, 2
nom_canton, character


# -- table_correspondance_drom (voir script DROM)
code_departement
numero_departement


any(nchar(unique(dataset$code_departement)) < 2)

# -- table_correspondance_découpage_administratif

code_departement
nom_departement
code_commune
nom_commune
code_circonscription
code_canton
nom_canton


# -- base_résultats_candidats

code_election
code_departement
code_commune
code_bureau_vote
code_liste
nom_liste
nom_liste_etendu
nom_candidat
nuance
voix


# -- base_résultats_élections

code_election
code_departement
code_commune
code_bureau_vote
inscrits
abstentions
votants
blancs
nuls
exprimes

codgeo_commune
codgeo_circonscription

