#!/bin/bash

clear
#on utilise cat pour afficher le menu suivi de deux echo pour sauter deux lignes
cat GlouMiam.txt
echo
echo
#prompt pour demander à l'utilisateur quel plat il souhaite modifier
read -p "Ecrivez le numéro du plat à modifier : " i ;

#on récupère la ligne correspondante dans le txt en utilisant grep et la regex [-] pour sélectionner le premier - avec le chiffre enregistré dans la variable i
grep -w [-]$i GlouMiam.txt ;

#prompt pour demander quelle information doit être changée dans la ligne
read -p "Que voulez-vous remplacer ? " mot ;
#prompt pour entrer la modification
read -p "Ecrivez les modification à apporter " input ;

#on utilise sed pour sélectionner le mot demandé et le remplacer par l'input donné
#Je n'est pas trouvé une commande ou des regex satisfaisantes pour garder l'alignement dans mon fichier texte 
sed -i "s/$mot/$input/g" GlouMiam.txt ;

exit 0 ;