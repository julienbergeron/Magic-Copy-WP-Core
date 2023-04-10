


## Les fichiers et dossier du programme

**Dossier :** _backup &#x2192; Un backup incrémental des modification avec des dates, un peu à la manière de TimeMachine, avec des liens durs (hardlink) vers les fichiers qui ne sont pas modifiés.

**Dossier :** _fichiers_actifs &#x2192; La liste des fichiers qui ont été modifié dans un fichier texte, *_fichiers_modif.txt_*, et une reproduction de l'arborescence avec une copie du fichier au bon endroit.  

**Fichier script 1 :** _trouver_fichier_copier.sh &#x2192; Dans un premier temps, faire un backup du contenu du dossiers _fichiers\_actifs_. Ensuite, trouver les fichiers qui ont une copie de travail et les copier avec leur arborescence dans _fichiers_actifs et garder une copie du chemin (path) de chacun dans le fichier _fichiers\_modif.txt_. 

**Fichier script 2 :** _remettre_fichier_a_leur_place.sh &#x2192; Remettre les fichiers à leur place à partir de la listes dans _fichiers\_modif.txt_.

**Fichier qui contient les path :** fichiers_modif.txt &#x2192; Liste des chemins (path) de tous les fichiers qui ont une copie de travail, un par ligne. 
