#!/bin/bash

clear
#on utilise cat pour afficher le menu suivi de 2 echos pour sauter deux lignes
cat GlouMiam.txt
echo
echo
#on demande à l'utilisateur le nombre de plat qu'il va sélectionner et on enregistre cette valeur dans une variable $nb
#on initialise une variable $i à 0 pour notre boucle
#on initialise une variable $nb à 1 comme valeur de fin à notre boucle afin qu'elle réalise
#toujours un premier tour au minimum on incrémentera plus tard sa valeur en fonction des
#choix de l'utilisateur
i=0 ;
total=0 ;
nb=1 ;
#on demande au while de boucler autant de fois qu'il y a de plats
while [ $i -lt $nb ] ; do
    read -p "Quel est le numéro du plat de votre commande ? " num ;
    #on enregistre dans une variable $plat la valeur sous forme de chiffre
    #du plat sélectionné grace aux commandes grep et des regex en utilisant
    #tr pour ne pas afficher "€"
    #puis on conserve dans une variable $com les sommes des plats*nbre de plats
    #et dans la variable $total la somme totale des commandes
    plat=$(grep -w [-]$num GlouMiam.txt | grep -o '[0-9]\{1,\}€' | tr -d '€') ;
    read -p "Combien en voulez-vous ? " mtp ;
    com=$((plat*mtp)) ;
    total=$((total+com)) ;
    ((i++)) ;
    #Je fait une boucle imbriquée pour demander à l'utilisateur s'il veut commander un autre plat et vérifier si la réponse est conforme et si c'est le cas j'ajoute une condition en fonction de (o/n). Enfin j'incrémente la variable nb qui représente la fin de ma première boucle ( continue 2 renvoi au début de la première boucle )
    read -n1 -p "Désirez-vous ajouter un autre plat ? (o/n) " reponse ;
        while [ "$reponse" != "o" ] && [ "$reponse" != "O" ] && [ "$reponse" != "n" ] && [ "$reponse" != "N" ]; do
            echo -e "\n$reponse n'est pas la bonne commande" ;
            read -n1 -p "Désirez-vous ajouter un autre plat ? (o/n) " reponse ;
        done
        if [ "$reponse" == "o" ] || [ "$reponse" == "O" ]; then
            echo
            ((nb++)) ;
            continue 2
        fi
        echo
done 
#on converti le total en ttc dans une fonction en utilisant bc pour prendre en compte les nbres flottants
function TVA () {
    TTC=$(echo "$total*1.1167" | bc) ;
    #printf "\n%.2f\n" $TTC
    #Ma commande pour arrondir au centième ne fonctionne pas ;
}
#on appelle la fonction TVA
TVA ;

#on fait une boucle pour demander à l'utilisateur de taper T en ignorant la casse
#jusqu'à ce qu'il le fasse pour afficher son TTC (on utilise -e dans le echo pour
#ignorer les caractères échappés et -n1 dans le read pour saisir une seule touche 
#sans appuyer sur "Entrer")
read -n1 -p 'Appuyer sur "T" pour avoir le total ' t ;
while [ "$t" != "T" ] && [ "$t" != "t" ] ; do
    echo -e "\n$t n'est pas la bonne commande" ;
    read -n1 -p 'Appuyer sur "T" pour avoir le total ' t ;
done
echo -e "\nLe total de votre commande est de : ${total} € HT soit ${TTC} € TTC" ;
#printf "\nle total de votre commande est de : ${total} € HT soit" TVA
exit 0 ;