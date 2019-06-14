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
SYMBOLS="../share/rpi_azerty_tweak/symbols"

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

echo "Norme AFNOR Z71-300" >> /tmp/msg_afnor.txt
echo "Pour en savoir plus, consultez :" > /tmp/msg_afnor.txt
echo "<http://norme-azerty.fr>" > /tmp/msg_afnor.txt
echo "La nouvelle norme sera appliquée à l'exception des caractères non francophones." > /tmp/msg_afnor.txt

whiptail --title "Clavier Azerty amélioré" --scrolltext --textbox /tmp/msg_afnor.txt 14 60


# Cible de la table de symboles
CIBLE="/usr/share/X11/xkb/symbols/$TABLE"
# Dossier des nouveaux symboles
SYMBOLS="../share/rpi_azerty_tweak/symbols"


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
		cherche "$TABLE" "MIN"
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

### Menu principal ###

MODE=$(whiptail --title "RPI AZERTY TWEAK" --menu "Que voulez-vous faire ?" 11 78 2 \
"(I)" "Installer une amélioration du clavier RPI" \
"(S)" "Supprimer toute modificatin du clavier RPI" 3>&1 1>&2 2>&3)

exitstatus=$?

 if [ $exitstatus = 0 ]; then
         case $MODE in
         "(I)")
                 # On appelle le script d'installation...
                 menu "$TABLE"
         ;;
         "(S)")
                 # On appelle la restauration
                 sudo /bin/bash ./restaure_rpi.sh "$TABLE"
         ;;
 	 esac

 else
         echo "Vous avez annulé.";exit
 fi
