#!/bin/bash

# Installation des ajustements du clavier RPI

# Variables
TABLE=fr

# On vérifie la sauvegarde de la table originale
./sauvegarde.sh $TABLE
 

# On propose un choix entre les corrections disponibles
./menu.sh


