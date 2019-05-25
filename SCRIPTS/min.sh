#!/bin/bash

CIBLE=/usr/share/X11/xkb/symbols/fr

echo "Correction de la touche '@ #'"

sudo cp --verbose -i ../symbols/fr_rpi_min $CIBLE

echo "réponse $?"

echo "La correction a été effectuée."

sleep 2
 
