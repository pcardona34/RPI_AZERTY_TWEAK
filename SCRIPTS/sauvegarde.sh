#!/bin/bash

# Initialisation des variables
SYM=/usr/share/X11/xkb/symbols/fr
SAUVE_INITIALE=$SYM.sauve

# On sauvegarde la table de symboles standard fr dans X11
# Si aucune sauvegarde initiale n'existe, on la crée...
if ! test -f $SAUVE_INITIALE
	then echo "Pas encore de sauvegarde initiale..."
	echo "On crée cette sauvegarde..."
	sudo cp -a $SYM $SAUVE_INITIALE
	$0;exit 
else
	echo "La configuration initiale de la table $(basename $SYM) a été sauvegardée."
fi 

