#!/bin/bash

# Ce script doit être exécuté avec les privilèges du compte root
if ! [ $(id -u) = 0 ]; then
   echo "Ce script doit être exécuté avec les privilèges du compte root."
   echo "Syntaxe : sudo /bin/bash $0"
   exit 1
fi

# Installation des ajustements du clavier RPI

# Variables
TABLE=fr

clear

# On vérifie la sauvegarde de la table originale
sudo /bin/bash ./sauvegarde.sh $TABLE
 
MODE=$(whiptail --title "RPI AZERTY TWEAK" --menu "Que voulez-vous faire ?" 11 78 2 \
"(I)" "Installer une amélioration du clavier RPI" \
"(S)" "Supprimer toute modificatin du clavier RPI" 3>&1 1>&2 2>&3)

exitstatus=$?

 if [ $exitstatus = 0 ]; then
         case $MODE in
         "(I)")
                 # On appelle le script d'installation...
                 sudo /bin/bash ./menu.sh
         ;;
         "(S)")
                 # On appelle la restauration
                 sudo /bin/bash ./restaure.sh
         ;;
 	 esac

 else
         echo "Vous avez annulé.";exit
 fi
