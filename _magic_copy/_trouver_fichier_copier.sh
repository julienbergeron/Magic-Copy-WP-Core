#!/bin/bash

##------------------------------------------------------/
##-----Table of content-----//
##Ligne : 20..........## Magic restore Core WordPress
##Ligne : 38..........## Comment configurer le fichier de backup
##Ligne : 52..........## Configuration
##Ligne : 55..........## Modifier uniquement ces valeurs
##Ligne : 72..........## Assignation des path aux variables
##Ligne : 85..........## Variables globales
##Ligne : 95..........## Fonction stringaleatoire() de création d'une chaine aléatoire
##Ligne : 108..........## Backup incrémentale de la dernière modification ave le fichier des path
##Ligne : 121..........## Effacer le contenu du backup précédent après le BackUp
##Ligne : 141..........## Trouver les fichiers modifiés et copier le path
##Ligne : 189..........## Copier les fichiers avec les diverses estensions dans le dossier _fichiers_actifs
##--@Table of content@--//
##======================================================/

##------------------------------------------------------/
##@ Magic restore Core WordPress
##------------------------------------------------------/

#Ce programme copie tous fichiers .php modifiés d’un site
#WordPress qui n'ont pas pu être mis dans le «Child Theme»
#Il les retrouves à l'aide dela forme du nom de fichier des copies
#avant travail, «nomedufichier (date heure).php». Il conserve
#le path de chacun des fichiers dans un fichier.txt et fait un backcup
#incrémentale des fichiers modifié avant de copier les nouveaux fichiers.

#Pour démarrer la copie il suffit de lancer la commande «sh _trouver_fichier_copier» après avoir compléter le fichier de config.

#Pour remmettre les fichiers à leur place pour revenir à leur version il suffit de faire la commande «sh _remettre_fichier_a_leur_place». Ce fichier est situé dans le même dossier. La configuration de ce fichiers doit également être complter.

## FIN Magic restore Core WordPress 
##======================================================/

##------------------------------------------------------/
##@ Comment configurer le fichier de backup
##------------------------------------------------------/
#  - _backup
#      - _fichiers_actifs_2023-02-25_13_06_41
#      - plus_recent
#  - _fichiers_actifs

# Se connecter en ssh avec CyberDuck, créer un dossier comme ceci :
# «_fichiers_actifs_2023-02-25_13_06_41» ensuite à l'aide du bouton droit
# de la souris sur le dosier «_fichiers_actifs_2023-02-25_13_06_41» activer 
# la commande «New Symbolic Link...» et nomer le lien symbolique «plus_recent»


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
    ##guillements à la place de $(dirname "$path_magic_copy")

    ##Liste des extensions supportées par le système
    EXTENSION=("po" "php" "js" "css" "jpg" "png")
    ## FIN Modifier uniquement cette valeur
    ##======================================================/
## FIN Configuration 
##======================================================/

echo "======================================================"
echo "======================================================"
# Obtenir le chemin absolu du répertoire parent du script

echo "======================================================"
echo "======================================================"

##------------------------------------------------------/
##@ Assignation des path aux variables
##------------------------------------------------------/

search_path="$absolute_path_dosser_web"
path_fichier_modif="$absolute_path_dosser_web"
nom_du_fichier_avec_les_path="/_magic_copy/_fichiers_modif.txt"
dossier_backup="$absolute_path_dosser_web""/_magic_copy/_backup"
dossier_fichiers_actifs="$absolute_path_dosser_web""/_magic_copy/_fichiers_actifs"

## FIN Assignation des path aux variables
##======================================================/

##------------------------------------------------------/
##@ Variables globales
##------------------------------------------------------/

## Déterminer le nombre d'éléments de la liste des extensions supportées
QTY_LISTE_EXTENSION=${#EXTENSION[@]}

## FIN Variable globale
##======================================================/

##------------------------------------------------------/
##@ Fonction stringaleatoire() de création d'une chaine aléatoire
##------------------------------------------------------/

function stringaleatoire {
    chaine_de_caractere_aleatoire=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
    echo $chaine_de_caractere_aleatoire
}


## FIN Fonction stringaleatoire() de création d'une chaine aléatoire
##======================================================/

##------------------------------------------------------/
##@ Backup incrémentale de la dernière modification avec le fichier des path
##------------------------------------------------------/

## Création d'un dossier avec la date à la fin
AUJOURDHUI=$(date '+%Y-%m-%d_%H_%M_%S')
mkdir "$dossier_backup""/_fichiers_actifs_""${AUJOURDHUI}"

## Créer un backup de la dernière version avant d'aller chercher les nouveau fichiers.
rsync -avH --delete --link-dest="$dossier_backup""/plus_recent" "$dossier_fichiers_actifs""/" "$dossier_backup""/_fichiers_actifs_""${AUJOURDHUI}"
rm -r "$dossier_backup""/plus_recent"

##Créer le lien symbolique vers la version la plus récente
ln -sf "$dossier_backup""/_fichiers_actifs_""${AUJOURDHUI}" "$dossier_backup""/plus_recent"


## FIN Backup incrémentale de la dernière modification 
##======================================================/

##------------------------------------------------------/
##@ Effacer le contenu du backup précédent après le BackUp 
## avant de copier les fichiers de la nouvelle recherche
##------------------------------------------------------/

## Effacer le contenu du fichier qui contient la liste complète
> "$path_fichier_modif""$nom_du_fichier_avec_les_path"

    ## if Effacer le contenu du dossier _fichiers_actifs si le dossier n'est pas vide
    if [ "$(ls -A $dossier_fichiers_actifs | wc -l)" -eq 0 ]; then
        echo "Le dossier est vide"
    else
        echo "Le dossier n'est pas vide"
        rm -r "$dossier_fichiers_actifs"/*
    fi
    ## FIN if Effacer le contenu du dossier _fichiers_actifs si le dossier n'est pas vide


## FIN Effacer le contenu du backup précédent après le BackUp
## avant de copier les fichiers de la nouvelle recherche 
##======================================================/

##------------------------------------------------------/
##@ Trouver les fichiers modifiés et copier le path
## Les fichiers modifés sont écrits dans un fichiers temporaire
## et ensuite copier dans _fichiers_modif.txt
## Une fois la copie effectuer le fichier temporaire est effacé
##------------------------------------------------------/
   i=0
   until [ ! $i -lt "$QTY_LISTE_EXTENSION" ]
     do
     
     #Création du fichier temporaire à l'aide d'une fonction qui
     #de création d'une chaine aléatoire pour lui donner un nom
     FICHIER_TEMPORAIRE=$(stringaleatoire)
     touch $FICHIER_TEMPORAIRE

#trouver les fichier qui ont une espace dans le nom et couper à partir de l'espace et copier leur emplacement dans un fichier aléatoire
#Chaque itération de la boucle crée un fichier aléatoire pour y 
#mettre la liste des fichiers qui a l'extension spécifique spéfifié dans la liste des extensions dans la config plus haut.

find "$search_path" -name "* *""${EXTENSION[i]}" | cut -f1 -d' ' >> "$path_fichier_modif""/_magic_copy/""$FICHIER_TEMPORAIRE"

#Affecter la valeur de l'extension dans une variable intermédiare
extension_intermediare="${EXTENSION[i]}"

#enlever l'extension à la fin s'il y a lieu
sed -i "/\.$extension_intermediare/d" "$path_fichier_modif""$nom_du_fichier_avec_les_path"
#effacer les lignes identiques
sed -nri 'G;/^([^\n]+\n)([^\n]+\n)*\1/!{P;h}' "$path_fichier_modif""/_magic_copy/""$FICHIER_TEMPORAIRE"

#remettre l'extension à la fin
sed -i "s/$/\.$extension_intermediare/" "$path_fichier_modif""/_magic_copy/""$FICHIER_TEMPORAIRE"


cat "$path_fichier_modif""/_magic_copy/""$FICHIER_TEMPORAIRE" >> "$path_fichier_modif""$nom_du_fichier_avec_les_path"

#Effacer le fichier temporaire
rm "$path_fichier_modif""/_magic_copy/""$FICHIER_TEMPORAIRE"


     i=`expr $i + 1`
   done

## FIN Trouver les fichiers modifier et copier le path 
##======================================================/

## TODO: Mettre une chaine de caractère aléatoire au début du path et au début du nom de fichier pour gérer le cas des fichiers avec le même méthode pensée, lire toutes les lignes et ajouter une chaine différente au début du path, renommer le fichier avec ce path au début au moment de faire la copie. Les fichier les path aurait cet forme «chaine aleatoire» avec un @ suivi du «path».


##------------------------------------------------------/
##@ Copier les fichiers avec les diverses estensions dans le dossier _fichiers_actifs
##------------------------------------------------------/

# Ouvrir le fichier en lecture seule
while read ligne
do
    # Traitement de chaque ligne
    cp -a --parents "$ligne" "$dossier_fichiers_actifs"
    cp "$path_fichier_modif""$nom_du_fichier_avec_les_path" "$dossier_fichiers_actifs"
    #echo "Ligne lue : $ligne"
done < "$path_fichier_modif""$nom_du_fichier_avec_les_path"
## FIN Copier les fichiers php dans le dossier _fichiers_actifs 
##======================================================/

exit

##------------------------------------------------------/
## NOTE: Copier un fichier en créant les fichiers de son path absolue
##------------------------------------------------------/
# Avec la command cp
#cp -a --parents /chemin/vers/mon_fichier /chemin/vers/mon_dossier/
# Avec la commande rsync
#rsync -R --relative /chemin/vers/mon_fichier /chemin/vers/mon_dossier/

## FIN NOTE: Créer les dossieer à partir du path
##======================================================/


##------------------------------------------------------/
## NOTE: Créer les dossieer à partir du path
##------------------------------------------------------/
# créer des fichier récusivement : mkdir -p d/s/a/e
# Créer un while avec différentes extensions

## FIN NOTE: Créer les dossieer à partir du path
##======================================================/

##------------------------------------------------------/
## NOTE: Créer des chaîne aleatoire
##------------------------------------------------------/
#https://linuxhint.com/generate-random-string-bash/
#https://gist.github.com/earthgecko/3089509

#cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1

## FIN NOTE:Créer des chaîne aleatoire
##======================================================/

##------------------------------------------------------/
## NOTE: Déterminer la quantié d'éléments d'un liste 
## et itération dans les éléments
##------------------------------------------------------/

##liste=(element1 element2 element3)
##printf "%s\n" "${#liste[@]}"


##Itérer les éléments d'une boucle
# Boucle pour itérer à travers chaque nom
#for nom in "${noms[@]}"
#do
    #echo "Le nom est $nom"
#done

## FIN NOTE: Déterminer la quantié d'éléments d'un liste et itération dans les éléments
##======================================================/

##------------------------------------------------------/
## NOTE: Exemple de boucles
##------------------------------------------------------/

#   k=0
#   until [ ! $k -lt "${#LARGEURCOLONNE[@]}" ]
#     do
#     TABLECOLGROUP+="<col style=\"width:${LARGEURCOLONNE[$k]}%\">"
#     k=`expr $k + 1`
#   done

## FIN NOTE: Exemple de boucles
##======================================================/
