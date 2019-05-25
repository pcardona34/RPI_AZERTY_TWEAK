#!/bin/bash

# Installation des ajustements du clavier RPI

# Variables
TABLE=fr

clear

# On vérifie la sauvegarde de la table originale
./sauvegarde.sh $TABLE
 
MODE=$(whiptail --title "RPI AZERTY TWEAK" --menu "Que voulez-vous faire ?" 11 78 2 \
"(I)" "Installer une amélioration du clavier RPI" \
"(S)" "Supprimer toute modificatin du clavier RPI" 3>&1 1>&2 2>&3)

exitstatus=$?

 if [ $exitstatus = 0 ]; then
         case $MODE in
         "(I)")
                 # On appelle le script d'installation...
                 ./menu.sh
         ;;
         "(S)")
                 # On appelle la restauration
                 ./restaure.sh
         ;;
 	 esac

 else
         echo "Vous avez annulé.";exit
 fi


