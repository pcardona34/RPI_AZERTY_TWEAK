#!/bin/bash

# Ce script doit être exécuté avec les privilèges du compte root
if ! [ $(id -u) = 0 ]; then
   echo "Ce script doit être exécuté avec le compte root." >&2
   echo "Syntaxe : sudo /bin/bash $0"
   exit 1
fi

# Initialisation des variables
SYM=/usr/share/X11/xkb/symbols/fr
SAUVE_INITIALE=$SYM.sauve

# On sauvegarde la table de symboles standard fr dans X11
# Si aucune sauvegarde initiale n'existe, on la crée...
if ! test -f "$SAUVE_INITIALE"
	then echo "Pas encore de sauvegarde initiale..."
	echo "On crée cette sauvegarde..."
	cp -a $SYM $SAUVE_INITIALE
	# Appel récursif
	sudo /bin/bash $0;exit 
else
	echo "La configuration initiale de la table $(basename $SYM) a été sauvegardée."
fi 
