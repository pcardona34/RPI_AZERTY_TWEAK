#!/bin/bash

# Choix du niveau d'ajustement
# Choice of the tweak level

CHOIX=$(whiptail --title "Niveau de l'ajustement du clavier RPI" --radiolist \
"Choisissez le niveau d'ajustement du clavier" 12 78 2 \
"TWEAK_MIN" "Correction de la touche '@ #'" ON \
"TWEAK_NF-Z71-300" "Clavier AZERTY amélioré (norme AFNOR)" OFF 3>&1 1>&2 2>&3)

exitstatus=$?

if [ $exitstatus = 0 ]; then
	case $CHOIX in
	"TWEAK_MIN")
		# On appelle le script de correction de la touche '@ #'...
		./cherche.sh "MIN"
	;;
	"TWEAK_NF-Z71-300")
		# On appelle le script d'apllication de la norme AFNOR, Azerty amélioré
		./cherhche.sh "AFNOR"
	;;
esac

else
	echo "Vous avez annulé.";exit
fi

