#!/bin/bash

# Ce script doit être exécuté avec les privilèges root
if ! [ $(id -u) = 0 ]; then
   echo "Ce script doit être exécuté avec le compte root." 
   echo "Syntaxe : sudo $0"
   exit 1
fi

# Cible de la table de symboles
CIBLE=/usr/share/X11/xkb/symbols/fr

echo "Correction de la touche '@ #'"

cp --verbose ../symbols/fr_rpi_min $CIBLE

echo "La correction a été effectuée."

sleep 2
 
echo "Pour appliquer les modifications, le système doit redémarrer..."
echo "Exécutez la commande : 'sudo shutdown --reboot now'"
