#!/bin/bash

CIBLE=/usr/share/X11/xkb/symbols/fr

echo "Correction de la touche '@ #'"

sudo cp --verbose ../symbols/fr_rpi_min $CIBLE

echo "La correction a été effectuée."

sleep 2
 
echo "Pour appliquer les modifications, le système doit redémarrer..."
echo "Exécutez la commande : 'sudo shutdown --reboot now'"

