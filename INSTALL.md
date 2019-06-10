# Installation de la correction de la touche `@ #`

Avant d'installer l'ajustement du clavier, vérifiez votre configuration.
Pour ce faire, ouvrez un terminal...

1. Votre clavier est-il concerné ?  
La commande suivante... 

     		pi@raspberrypi: usb-devices|grep "Vendor=04d9 ProdID=0006"
		
...doit retourner un résultat :

     		P:  Vendor=04d9 ProdID=0006 Rev=01.10

2. Assurez-vous d'avoir au préalable choisi la variante alternative
de la disposition française du clavier en exécutant l'utilitaire de 
configuration de _raspbian_ :

     		pi@raspberrypi: sudo raspi-config

Puis sélectionnez l'item :  

     		`4 Localisation Options...`

Puis l'option : 

     		`I3  Change Keyboard Layout...`

Choisissez successivement les options suivantes :

+ Modèle du clavier : `PC générique 105 touches (intl)`
+ Disposition du clavier : `Français - Français (variante)`

Validez...

3. Déplacez-vous dans le dossier SCRIPTS pour y exécuter le script `main.sh` avec 
les privilèges root :

      		pi@raspberrypi: cd SCRIPTS
      		pi@raspberrypi: sudo /bin/bash ./main.sh

4. Une fois l'installation terminée, redémarrez votre Pi afin de  
prendre en compte les changements :

     		pi@raspberrypi: sudo shutdown --reboot now
    
5. Dans la nouvelle session, testez le clavier :
    a) Pour la version minimale :


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

    b) Pour la version Afnor « Azerty amélioré », comparez votre saisie au site de 
    référence :

    <http://norme-azerty.fr/#explore>
   
    Vous trouverez aussi les tests que j’ai effectués dans le dossier TESTS.

# Suppression / désinstallation

+ Exécutez à nouveau le script `main.sh` (cf. étape 3) et choisissez l'item :

		(S)  Supprimer...

# État du projet

+ La variante "AZERTY amélioré" est disponible depuis le 10/06/2019. + Elle est 
fonctionnelle pour la saisie de textes francophones, et secondairement, en 
anglais, espagnol, occitan, catalan. Par contre, les caractères plus rares 
(slovène, etc) ne sont pas disponibles.
