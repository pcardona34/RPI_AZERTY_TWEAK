#!/bin/bash

# Initialisation des variables
TABLE=/usr/share/X11/xkb/symbols/fr
MOTIF=$1

if test -z $MOTIF
then 
	echo "Syntaxe : $0 [MIN|AFNOR]";exit 1
fi

# On cherche dans la table si une correction a été écrite et laquelle

if test -f $TABLE
then

	if cat $TABLE|grep "TWEAK_RPI_$MOTIF"
	then
		echo "L'ajustement de la table référencé ${MOTIF} a déjà été installé."
	else
		echo "Installation de l'ajustement ${MOTIF}..."
		case $MOTIF in
		"MIN")
		./min.sh
		;;
		"AFNOR")
		./afnor.sh
		;;
		esac
	fi
fi
