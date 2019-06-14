# Installation de la correction de la touche `@ #`

## 1. Simplification de la procédure

La nouvelle version de `rpi_azerty_tweak` teste automatiquement votre clavier 
afin de savoir s'il est concerné par le correctif proposé.

De même, la disposition du clavier est désormais automatiquement paramétrée :
		
		Français - Français (variante)`

## 2. Installation

Pour bénéficier de l'une des améliorations du clavier, il suffit 
d'installer le paquet ainsi :

		sudo dpkg -i rpiazertytweak.deb`

Il vous sera alors proposé de choisir l'amélioration à installer.

Une fois l'installation terminée, redémarrez votre Pi afin de  
prendre en compte les changements :

     		pi@raspberrypi: sudo shutdown --reboot now
    
## 3. Test de la nouvelle disposition

Dans la nouvelle session, testez le clavier :

### a) Pour la version minimale :

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
    Le reste a été rendu possible par la variante "oss" (français - variante).


### b) Pour la version « Azerty amélioré » (norme AFNOR)

+ Comparez votre saisie au site de référence :

    <http://norme-azerty.fr/#explore>
   
+ Vous trouverez aussi les tests que j’ai effectués dans le dossier TESTS :

		less /usr/local/share/rpiazertytweak/TESTS/test_afnor.txt

# Suppression / désinstallation

+ Exécutez la procédure suivante :

		sudo dpkg -u rpiazertytweak

# État du projet

+ La variante "AZERTY amélioré" est disponible depuis le 10/06/2019.

+ Elle est fonctionnelle pour la saisie de textes francophones, et 
secondairement, en anglais, espagnol, occitan, catalan. Par contre, les 
caractères plus rares (slovène, etc) ne sont pas encore disponibles.

+ Un paquet d'installation rpiazertytweak.deb est disponible depuis le 14 juin 2019.
