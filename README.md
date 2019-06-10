# RPI_AZERTY_TWEAK

Ajustement de la disposition du clavier officiel RPI - variante FR 
AZERTY (_Layout Tweak of the official RPI keyboard - French AZERTY 
variant_)

​

# Qui est concerné ?

+ Vous avez acquis un clavier officiel de la fondation _Raspberry Pi_, 
clavier de 79 touches dans la disposition AZERTY, et vous avez constaté 
que la nouvelle touche gravée avec les caractères `@ #` ne produisait 
pas la saisie attendue.  
En effet, cette touche produit alors 
indifféremment le caractère `²`, avec ou sans modificateur "majuscule" 
(SHIFT).
+ Vous utilisez votre _Raspberry Pi_ avec le système 
préconisé, la distribution _Raspbian_ (_debian_ sur processeur Arm). ​ 

# Quels niveaux de correction sont envisagés ?

1. On peut d'abord envisager un niveau de correction élémentaire : 
faire en sorte que la touche en question, `@ #` produise la saisie des 
caractères attendus.  Et on peut aussi en profiter pour régler la perte 
de la saisie de la ligature œ/Œ... 
2. On peut aussi envisager 
d'implémenter la nouvelle norme AFNOR, NFZ71-300, qui étend les 
possibilités du clavier AZERTY pour permettre une saisie complète et 
plus facile des caractères de la typographie française.

+ La première correction basique sera donc appelée TWEAK_RPI_MIN.
+ La seconde sera appelée TWEAK_RPI_NF-Z71-300 et permettra d'étendre les 
possibilités du clavier. Dans ce cas, en attendant une évolution 
compatible de la disposition imprimée sur les touches du clavier, vous 
pouvez 
[commander](https://www.tastaturaufkleber.eu/Tastaturaufkleber/Tastaturaufkleber-PC/Franzoesisch/Tastaturaufkleber-Franzoesisch-AZERTY-ameliore::286.html) 
ou créer vous-même vos étiquettes compatibles avec le clavier "AZERTY 
amélioré" (voir les références ci-dessous).

## Références
​
+ Sur le site de l'AFNOR : <https://normalisation.afnor.org/actualites/faq-clavier-francais/>

+ Site dédié : <http://norme-azerty.fr/>

## Étiquettes compatibles avec le clavier AZERTY amélioré, à imprimer soi-même...
​
+ <https://github.com/marcbal/Printable-AZERTY-NF>
​
# Quelle méthode d'ajustement est envisagée ?

Il s'agit, après sauvegarde, de modifier la disposition d'un clavier 
standard pc105 (cf. la présence de la touche `< >`) en allant ajuster 
dans la configuration de X11 la variante `Unicode French derivative` de 
la table de symboles `fr` (à partir de la ligne 99) et notamment de 
corriger la ligne 136 associée à la touche `TLDE` pour lui affecter les 
caractères `at` pour @ (niveau 1) et `numbersign` pour # (au niveau deux).

Pour y parvenir, on utilisera un fichier de configuration alternatif et des 
scripts Bash pour effectuer les opérations d'installation (sauvegarde 
de la table standard, substitution) ou de désinstallation 
(rétablissement de la table standard). 

Une fois les modifications 
effectuées, il s'agit de rendre la chose transparente pour 
l'utilisateur : aucun script inhabituel ne doit être exécuté au 
démarrage. 

Il doit être enfin possible de revenir en arrière et de 
supprimer toutes les modifications effectuées simplement.

# Quand le code sera-t-il disponible ?

+ La première correction basique TWEAK_RPI_MIN est effective : code publié le 25/05/2019/
+ La seconde, TWEAK_RPI_NF-Z71-300, est disponible depuis le 10/06/2019
​
# Remerciements

+ Merci à "CrazyCat" du forum <https://forum.raspfr.org> pour ses conseils sur 
l'amélioration du code.
