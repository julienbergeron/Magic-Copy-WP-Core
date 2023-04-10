#!/bin/bash

##------------------------------------------------------/
##@ Configuration
##------------------------------------------------------/

    ##@ Modifier uniquement ces valeurs
    ## à noter que la configuration du path se fait automatiquement
    ## mais le dossier _magic_copy doit être sur le premier niveau du
    ## dossier web (public_html)
    ##------------------------------------------------------/
    parent_dir=$(dirname "$(readlink -f "$0")")
    # Changer le répertoire de travail actuel en répertoire parent
    cd "$parent_dir"
    
    # Obtenir le chemin absolu du répertoire de travail actuel
    path_magic_copy=$(pwd)
    absolute_path_dosser_web=$(dirname "$path_magic_copy")
    ##Pour trouver la valeur se rendre en terminal dans le dossier web 
    ##généralement public_html ou le premier niveau du site
    ##Taper pwd dans l'invite de commande
    ##Copier le chemin et remplacer ci-haut il faudrait alors écrire le code
    ##Sans la ligne 60 et mettre le path récupérer avec la commande pwd entre
    ##guillements à la place de $(dirname "$path_magic_copy")r

search_path="$absolute_path_dosser_web"
path_fichier_modif="$absolute_path_dosser_web"
nom_du_fichier_avec_les_path="/_magic_copy/_fichiers_modif.txt"
dossier_backup="$absolute_path_dosser_web""/_backup"
dossier_fichiers_actifs="$absolute_path_dosser_web""/_magic_copy/_fichiers_actifs"

## FIN Configuration 
##======================================================/

##------------------------------------------------------/
##@ Recopier les fichiers vers le emplacement d'origine
##------------------------------------------------------/
# Ouvrir le fichier en lecture seule
while read ligne
do
    #garder seulement le nom du fichier dans le path avec basename
    #nom_du_fichier=$(basename ${ligne})
    # Traitement de chaque ligne
    cp "$dossier_fichiers_actifs$ligne" "$ligne"
    echo "Ligne lue : $ligne"
done < "$path_fichier_modif""$nom_du_fichier_avec_les_path"
## FIN Copier les fichiers php dans le dossier _fichiers_actifs 
##======================================================/
