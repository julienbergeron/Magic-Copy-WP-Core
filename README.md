## Fonctionnement

### Installation

Copier le dossier *_magic_copy* sur le premier niveau du dossier web sur le serveur. Généralement c'est le dossier *public_html*.

### Utilisation

#### 1. Copier et faire un backup des modifications

```
bash _trouver_fichier_copier.sh
```

#### 2. Restaurer ou remettre les fichiers à leur place

```
bash _remettre_fichier_a_leur_place.sh
```


## Les fichiers et dossier du programme

**Dossier :** *_backup* &#x2192; Un backup incrémental des modifications avec des dates, un peu à la manière de Time Machine, avec des liens durs (hard link) vers les fichiers qui ne sont pas modifiés après une mise à jour.

**Dossier :** *_fichiers_actifs* &#x2192; La liste des fichiers qui ont été modifié dans un fichier texte, *_fichiers_modif.txt_*, et une reproduction de l'arborescence avec une copie du fichier au bon endroit.  

**Fichier script 1 :** *_trouver_fichier_copier.sh* &#x2192; Dans un premier temps, faire un «backup» du contenu du dossiers *_fichiers_actifs*. Ensuite, trouver les fichiers qui ont une copie de travail et les copier avec leur arborescence dans *_fichiers_actifs* et garder une copie du chemin (path) de chacun dans le fichier *_fichiers_modif.txt*. 

**Fichier script 2 :** *_remettre_fichier_a_leur_place.sh* &#x2192; Remettre les fichiers à leur place à partir de la liste dans *_fichiers_modif.txt*.

**Fichier qui contient les paths :** *fichiers_modif.txt* &#x2192; Liste des chemins (path) de tous les fichiers qui ont une copie de travail, un par ligne.

>Le programme est auto-config et utilise le «path» absolu du dossier web du serveur (public_html)

>À la première utilisation, le programme indique dossier manquant, parce qu'il ne peut faire un backup avant une première utilisation du script. 
