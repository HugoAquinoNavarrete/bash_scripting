#!/bin/bash

# Código que muestra como filtrar información usando el comando "cut" tomando como argumento un año
# ./10-mlb_equipos.sh <year>

arreglo_mlb_equipo=()
arreglo_mlb_audiencia=()
size=0

if [ ! -d ../output ]; then
  mkdir ../output
fi

if [ $# -eq 0 ]; then
   echo "El script se ejecuta de la siguiente manera: ./10-mlb_equipos.sh <year>"

elif [ $# -gt "1" ]; then
   echo "El script sólo necesita un parámetro para ejecutarse"

else
      
   echo "Buscando equipos para el año $1"
   cat ../input/mlb_teams.csv | grep -E "^$1" | cut -d , -f41 > ../output/mlb_equipos_year_$1.txt

   arreglo_mlb_equipo=($(cat ../input/mlb_teams.csv | grep -E "^$1" | cut -d , -f3))
   arreglo_mlb_audiencia=($(cat ../input/mlb_teams.csv | grep -E "^$1" | cut -d , -f43))

   size=${#arreglo_mlb_equipo[@]}

   echo "ID_equipo,audiencia" > ../output/mlb_audiencia_year_$1.txt

   for (( i=0; i<$size; i++ )); 
   do 
      echo "${arreglo_mlb_equipo[$i]},${arreglo_mlb_audiencia[$i]}" >> ../output/mlb_audiencia_year_$1.txt
   done

   echo "Esta es la información encontrada de la audiencia"
   cat ../output/mlb_audiencia_year_$1.txt

   echo ""
   echo "Esta es la información encontrada de los equipos"
   cat ../output/mlb_equipos_year_$1.txt

fi

