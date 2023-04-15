#!/bin/bash

#Ethical Brands Version 0.4: Adds counter of total etichal brands found
#Velid Agovic 2023

#saznaj broj brendova
broj=$(wc -l < brendovi.txt)

#kreiraj promjenjivu koja ce pratiti total broj dobrih brendova
total=0 
#kreiraj array
declare -a brendovi

#zapocni for loop
for ((i=1; i<=$broj/2+1; i++ ))
do 
    brand=$(grep -A1 $i brendovi.txt | sed -n 2p)
    curl --silent -o temp.txt "https://directory.goodonyou.eco/brand/"$brand
    
#napravi nove redove
    sed -i 's/,/\n/g' temp.txt
    sed -i 's/:/\n/g' temp.txt

#dodati boju
    farbati=$(grep -A1 ethicalLabel temp.txt  | sed -n 2p)

#Zelena   
if [[ "$farbati" == *"Good"* ]]
then 
echo -e $i "- \e[1;42m"$brand": \e[0m"
grep -A1 ethicalLabel temp.txt  | sed -n 2p
grep -A1 ethicalInfo1 temp.txt  | sed -n 2p
echo "______________________________"
echo " "
total=$((total+1))
brendovi+=("$brand")
brendovi+=(",")

#Zuta  
elif [[ "$farbati" == *"start"* ]]
then 
echo -e $i "- \e[1;33m"$brand": \e[0m"
grep -A1 ethicalLabel temp.txt  | sed -n 2p
grep -A1 ethicalInfo1 temp.txt  | sed -n 2p
echo "______________________________"
echo " "
#Crvena  
elif [[ "$farbati" == *"avoid"* ]]
then 
echo -e $i "- \e[1;31m"$brand": \e[0m"
grep -A1 ethicalLabel temp.txt  | sed -n 2p
grep -A1 ethicalInfo1 temp.txt  | sed -n 2p
echo "______________________________"
echo " "
#Teal
elif [[ "$farbati" == *"Great"* ]]
then 
echo -e $i "- \e[1;36m"$brand": \e[0m"
grep -A1 ethicalLabel temp.txt  | sed -n 2p
grep -A1 ethicalInfo1 temp.txt  | sed -n 2p
echo "______________________________"
echo " "
#Crna
elif [[ "$farbati" == *"Not"* ]]
then 
echo -e $i "- \e[1;30m"$brand": \e[0m"
grep -A1 ethicalLabel temp.txt  | sed -n 2p
grep -A1 ethicalInfo1 temp.txt  | sed -n 2p
echo "______________________________"
echo " "

fi

done
echo "Number of ethical brands: " $total
echo ${brendovi[@]}



