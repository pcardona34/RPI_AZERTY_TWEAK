#!/bin/bash

# Ce script doit être exécuté avec le compte root

if ! [ $(id -u) = 0 ]; then
   echo "Ce script doit être exécuté avec le compte root."
   echo "Syntaxe : sudo /bin/bash $0"
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

# Initialisation des variables
SYM=/usr/share/X11/xkb/symbols/fr
SAUVE_INITIALE=$SYM.sauve

# On restaure la table par défaut dans la conf de X11
if test -f $SAUVE_INITIALE
	then
	 echo "Restauration de la table par défaut..."
	 cp -a $SAUVE_INITIALE $SYM
	 rm $SAUVE_INITIALE
	 echo "Pour appliquer les modifications, le système doit redémarrer..."
	 echo "Exécutez la commande : 'sudo shutdown --reboot now'"
else
	echo "La configuration initiale de la table $(basename $SYM) a été restaurée."
fi 

