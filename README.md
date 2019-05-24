# RPI_AZERTY_TWEAK
Ajustement de la disposition du clavier officiel RPI - variante FR AZERTY (_Layout Tweak of the official RPI keyboard - French AZERTY variant_)

# Qui est concerné ?
+ Vous avez acquis un clavier officiel de la fondation _Raspberry Pi_, clavier de 79 touches dans la disposition AZERTY, et vous avez constaté que la nouvelle touche gravée avec les caractères `@ #` ne produisait pas la saisie attendue.  
En effet, cette touche produit alors indifféremment le caractère `²`, avec ou sans modificateur "majuscule" (SHIFT).
+ Vous utilisez votre _Raspberry Pi_ avec le système préconisé, la distribution _Raspbian_ (_debian_ sur processeur Arm).

# Quels niveaux de correction sont envisagés ?

1. On peut d'abord envisager un niveau de correction élémentaire : faire en sorte que la touche en question, `@ #` produise les caractères attendus.
2. On peut aussi envisager d'implémenter la nouvelle norme AFNOR, NFZ71-300, qui étend les possibilités du clavier AZERTY pour permettre une saisie complète et facile des caractères de la typographie française.

+ La première correction basique sera donc appelée TWEAK_MIN.
+ La seconde sera appelée TWEAK_NF-Z71-300 et permettra d'étendre les possibilités du clavier. Dans ce cas, en attendant une évolution compatible de la disposition imprimée du clavier, vous pouvez commander ou créer vous-même vos étiquettes compatibles avec le clavier AZERTY amélioré.

## Références
<https://normalisation.afnor.org/actualites/faq-clavier-francais/>

# Quelle méthode est envisagée ?
Il s'agit, après sauvegarde, de modifier la disposition pc105 proposée dans la configuration X11 du clavier en lien avec la variante French. Pour y parvenir, on utilisera des fichiers de configuration et des scripts Bash.
Une fois les modifications effectuées, il s'agit de rendre la chose transparente pour l'utilisateur : aucun script inhabituel ne doit être exécuté au démarrage.
Il doit être enfin possible de revenir en arrière et de supprimer toutes les modifications effectuées. C'est pourquoi la démarche doit s'appuyer au final sur un paquet standard de la distribution.

# Quand le code sera-t-il disponible ?
+ Travail en cours... (Work in progress)
