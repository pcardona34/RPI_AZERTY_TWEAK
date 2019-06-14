#!/bin/bash

# Ce script doit être exécuté avec les privilèges du compte root
if ! [ $(id -u) = 0 ]; then
   echo "Ce script doit être exécuté avec les privilèges du compte root."
   echo "Syntaxe : sudo /bin/bash $0"
   exit 1
fi

# Le paramètre $1 ne doit pas être vide
if test -z "$1"
then echo -e "Syntaxe\n$0 [NOM_TABLE]\nPar exemple :\n$0 fr"
exit 1
fi

####  Variables ####
TABLE="$1"

####################

#### Fonctions / functions ####

### clavier_rpi #################################
# On vérifie si le clavier est concerné par le correctif MIN

function clavier_rpi
{

RPI=1

# On vérifie si le clavier est un clavier officiel RPI
usb-devices|grep -q "Vendor=04d9 ProdID=0006"
if [ $? = 0 ]
then
	RPI=0
fi

return $RPI
}

### disposition #################################
# On vérifie si la disposition est bien "french alternative"
# c-à-d dans /etc/default/keyboard : 
# XKBMODEL="pc105"
# XKBLAYOUT="fr"
# XKBVARIANT="oss"

function disposition
{

# Préparation du message d'erreur
echo -e "Exécutez d'abord :\n sudo raspi_config \nafin de modifier la configuration de " > /tmp/msgclavier.txt
echo "votre clavier ainsi :" >> /tmp/msgclavier.txt
echo "- Modèle du clavier : 'PC générique 105 touches (intl)' " >> /tmp/msgclavier.txt
echo "- Disposition du clavier : 'Français - Français (variante)' " >> /tmp/msgclavier.txt

grep -q /etc/default/keyboard -e "XKBMODEL=\"pc105\""
if [ $? != 0 ]
then 
	whiptail --title "ERREUR" --textbox /tmp/msgclavier.txt 14 60
	return 1
fi

grep -q /etc/default/keyboard -e "XKBLAYOUT=\"fr\""
if [ $? != 0 ]
then 
	whiptail --title "ERREUR" --textbox /tmp/msgclavier.txt 14 60
	return 1
fi

grep -q /etc/default/keyboard -e "XKBVARIANT=\"oss\""
if [ $? != 0 ]
then 
	whiptail --title "ERREUR" --textbox /tmp/msgclavier.txt 14 60
	return 1
fi

# Sinon, c'est OK.
echo "La disposition et sa variante sont conformes : fr-oss"
return 0
}

### sauvegarde ###################################
# Permet de sauvegarder la table originale
# Paramètres :
# $1 : nom de la table à sauvegarder (fr, etc)
##################################################

function sauvegarde
{

# Initialisation des variables
TABLE="$1"
SYM="/usr/share/X11/xkb/symbols/$TABLE"
SAUVE_INITIALE="$SYM.sauve"

# On sauvegarde la table de symboles standard fr dans X11
# Si aucune sauvegarde initiale n'existe, on la crée...
if ! test -f "$SAUVE_INITIALE"
	then echo "Pas encore de sauvegarde initiale..."
	echo "On crée cette sauvegarde..."
	cp -a "$SYM" "$SAUVE_INITIALE"
	# Appel récursif
	sauvegarde "$TABLE"
else
	echo "La configuration initiale de la table $(basename $SYM) a été sauvegardée."
fi

}

#### min ################################################################
# Installe la correction minimale du clavier RPI : touches "#" et "@"
# Paramètres :
# $1 : nom de la table

function min
{

TABLE="$1"
# Cible de la table de symboles
CIBLE="/usr/share/X11/xkb/symbols/$TABLE"
# Dossier des nouveaux symboles
SYMBOLS="/usr/local/share/rpi_azerty_tweak/symbols"

# On vérifie la disposition
if ! (disposition)
then
	exit 1
fi

echo "Correction de la touche '@ #'"

cp --verbose "$SYMBOLS/fr_rpi_min" "$CIBLE"

echo "La correction a été effectuée."

sleep 2
 
whiptail --title "Information" --msgbox "Pour appliquer les modifications, le système doit redémarrer...\nExécutez la commande : 'sudo shutdown --reboot now'" 10 60

}

#### afnor ##############################################################
# Installation du pilote de clavier azerty amélioré (norme AFNOR) 
# Paramètres :
# $1 : nom de la table

function afnor
{

TABLE="$1"

# On vérifie la disposition
if ! (disposition)
then
	exit 1
fi

echo "Norme AFNOR Z71-300" > /tmp/msg_afnor.txt
echo "Pour en savoir plus, consultez :" >> /tmp/msg_afnor.txt
echo "<http://norme-azerty.fr>" >> /tmp/msg_afnor.txt
echo "La nouvelle norme sera appliquée à l'exception des caractères non francophones." >> /tmp/msg_afnor.txt

whiptail --title "Clavier Azerty amélioré" --scrolltext --textbox /tmp/msg_afnor.txt 14 60


# Cible de la table de symboles
CIBLE="/usr/share/X11/xkb/symbols/$TABLE"
# Dossier des nouveaux symboles
SYMBOLS="/usr/local/share/rpi_azerty_tweak/symbols"

echo -e "\nAdaptation à la norme AFNOR en cours..."

cp --verbose "$SYMBOLS/fr_rpi_afnor" "$CIBLE"

if [ $? = 0 ]
 then echo "La modification a été effectuée."
else
 echo "Une erreur s'est produite : $?"
fi
sleep 2

whiptail --title "Information" --msgbox "Pour appliquer les modifications, le système doit redémarrer...\nExécutez la commande : 'sudo shutdown --reboot now'" 10 60

}

#### cherche #############################################################
# Variables :
# $1 : nom de la table (fr, etc)
# $2 : motif de la recherche : "MIN" ou "AFNOR"

function cherche
{

# Initialisation des variables
TABLE="$1"
CHEMIN="/usr/share/X11/xkb/symbols/$TABLE"
MOTIF="$2"

# On cherche dans la table si une correction a été écrite et laquelle

if test -f "$CHEMIN"
then

	if cat "$CHEMIN"|grep -q "TWEAK_RPI_$MOTIF"
	then
		echo "L'ajustement de la table référencé ${MOTIF} a déjà été installé."
	else
		echo "Installation de l'ajustement ${MOTIF}..."
		case "$MOTIF" in
		"MIN")
		min "$TABLE"
		;;
		"AFNOR")
		afnor "$TABLE"
		;;
		esac
	fi
fi

}

#### menu ##################################################################
# menu secondaire : choix du niveau d'ajustement / Choice of the tweak level
# Paramètre :
# $1 : nom de la table

function menu
{

TABLE="$1"

CHOIX=$(whiptail --title "Niveau de l'ajustement du clavier RPI" --radiolist \
"Choisissez le niveau d'ajustement du clavier" 12 78 2 \
"TWEAK_MIN" "Correction de la touche '@ #'" ON \
"TWEAK_NF-Z71-300" "Clavier AZERTY amélioré (norme AFNOR)" OFF 3>&1 1>&2 2>&3)

exitstatus=$?

if [ $exitstatus = 0 ]; then
	case $CHOIX in
	"TWEAK_MIN")
		# On appelle le script de correction de la touche '@ #'...
		if (clavier_rpi)
		    then echo "Le clavier est concerné par le correctif."
  		    cherche "$TABLE" "MIN"
		else
		    whiptail --title "ERREUR" --msgbox "Votre clavier n'est pas concerné par ce correctif." 8 60
		fi
	;;
	"TWEAK_NF-Z71-300")
		# On appelle le script d'application de la norme AFNOR, Azerty amélioré
		cherche "$TABLE" "AFNOR"
	;;
esac

else
	echo "Vous avez annulé.";exit
fi


}

############ Fin des fonctions / end of the functions #################

# Installation des ajustements du clavier RPI

clear

# On vérifie la sauvegarde de la table originale
sauvegarde "$TABLE"

# On appelle le script d'installation...
menu "$TABLE"
