#!/bin/bash

# Ce script doit être exécuté avec les privilèges root
if ! [ $(id -u) = 0 ]; then
   echo "Ce script doit être exécuté avec le compte root." 
   echo "Syntaxe : sudo $0"
   exit 1
fi

echo "Norme AFNOR Z71-300"
echo "Pour en savoir plus, consultez :"
echo "<http://norme-azerty.fr>"
echo "La nouvelle norme sera appliquée à l'exception des caractères non francophones."


# Cible de la table de symboles
CIBLE=/usr/share/X11/xkb/symbols/fr

echo -e "\nAdaptation à la norme AFNOR en cours..."

cp --verbose ../symbols/fr_rpi_afnor $CIBLE

if [ $? = 0 ]
 then echo "La modification a été effectuée."
else
 echo "Une erreur s'est produite : $?"
fi
sleep 2
 
echo "Pour appliquer les modifications, le système doit redémarrer..."
echo "Exécutez la commande : 'sudo shutdown --reboot now'"


exit

