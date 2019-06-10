#!/bin/bash

# Ce script doit être exécuté avec les privilèges root
if ! [ $(id -u) = 0 ]; then
   echo "Ce script doit être exécuté avec les privilèges root."
   echo "Syntaxe : sudo /bin/bash $0"
   exit 1
fi

# Initialisation des variables
TABLE=/usr/share/X11/xkb/symbols/fr
MOTIF="$1"

if test -z "$MOTIF"
then 
	echo "Syntaxe : $0 [MIN|AFNOR]";exit 1
fi

# On cherche dans la table si une correction a été écrite et laquelle

if test -f "$TABLE"
then

	if cat "$TABLE"|grep -q "TWEAK_RPI_$MOTIF"
	then
		echo "L'ajustement de la table référencé ${MOTIF} a déjà été installé."
	else
		echo "Installation de l'ajustement ${MOTIF}..."
		case "$MOTIF" in
		"MIN")
		sudo /bin/bash ./min.sh
		;;
		"AFNOR")
		sudo /bin/bash ./afnor.sh
		;;
		esac
	fi
fi
