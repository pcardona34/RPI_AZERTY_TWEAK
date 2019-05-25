#!/bin/bash

# Initialisation des variables
SYM=/usr/share/X11/xkb/symbols/fr
SAUVE_INITIALE=$SYM.sauve

# On restaure la table par défaut dans la conf de X11
if test -f $SAUVE_INITIALE
	then
	 echo "Restauration de la table par défaut..."
	 sudo cp -a $SAUVE_INITIALE $SYM
	 sudo rm $SAUVE_INITIALE
	 echo "Pour appliquer les modifications, le système doit redémarrer..."
	 echo "Exécutez la commande : 'sudo shutdown --reboot now'"
else
	echo "La configuration initiale de la table $(basename $SYM) a été restaurée."
fi 

