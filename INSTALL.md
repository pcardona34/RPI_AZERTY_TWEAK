# Installation de la correction de la touche `@ #`

Avant d'installer l'ajustement du clavier, vérifiez votre configuration.
Pour ce faire, ouvrez un terminal...

1. Votre clavier est-il concerné ?  
La commande suivante doit retourner un résultat :

     		pi@raspberrypi: usb-devices|grep "Vendor=04d9 ProdID=0006"

     		P:  Vendor=04d9 ProdID=0006 Rev=01.10

2. Assurez-vous d'avoir au préalable choisi la variante alternative
de la disposition française du clavier en exécutant l'utilitaire de 
configuration de raspbian :

     		pi@raspberrypi: sudo raspi_config

Puis sélectionnez l'item :  

     		`4 Localisation Options...`

Puis l'option : 

     		`I3  Change Keyboard Layout...`

Choisissez successivement les options suivantes :

+ Modèle du clavier : `PC générique 105 touches (intl)`
+ Disposition du clavier : `Français - Français (variante)`

Validez...

3. Déplacez-vous dans le dossier SCRIPTS pour y exécuter le script  

      		pi@raspberrypi: ./main.sh

Au besoin, rendez tous les scripts exécutables dans le dossier.

     		pi@raspberrypi: cd SCRIPTS

     		pi@raspberrypi: chmod +x *.sh

     		pi@raspberrypi: ./main.sh

4. Une fois l'installation terminée, redémarrez votre Pi afin de  
prendre en compte les changements :

     		pi@raspberrypi: sudo shutdown --reboot now
    
5. Dans la nouvelle session, testez le clavier :

	| Modificateur | Touche | Affichage |
	|--------------|--------|-----------|
	| (aucun)      | `@ #`  | @         |               |
	| Shift        | `@ #`  | #         |
 	| Alt-Gr       | `o`    | œ         |
	| Alt-Gr+Shift | `o`    | Œ         |
	| Alt-Gr       | `w`    | «         |
	| Alt-Gr       | `x`    | »         |

+ **Remarque** :

La correction spécifique porte sur la touche `@ #`.
Le reste a été rendu possible par la variante choisie au cours de  
l'étape 2.

# Suppression / désinstallation

+ Exécutez à nouveau le script `main.sh` et choisissez l'item :

		(S)  Supprimer...

# État du projet

+ La variante "AZERTY amélioré" n'est pas encore disponible. 
