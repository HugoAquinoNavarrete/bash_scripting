#!/bin/bash

# Código que muestra como filtrar información usando el comando "cut" tomando como argumento un año
# ./10-mlb_equipos.sh 

arreglo_mlb_equipo=()
arreglo_mlb_audiencia=()
size=0

if [ ! -d ../output ]; then
  mkdir ../output
fi

if [ ! -f ../input/year.txt ]; then
   echo "Falta el archivo \"year.txt\" para que el script se ejecute correctamente"

else
      
    echo "El año del cual obtendremos información es:"
    cat ../input/year.txt
    year=$( cat ../input/year.txt )
   echo "Buscando equipos para el año $year"

   arreglo_mlb_equipo=($(cat ../input/mlb_teams.csv | grep -E "^$year" | cut -d , -f3))
   arreglo_mlb_audiencia=($(cat ../input/mlb_teams.csv | grep -E "^$year" | cut -d , -f43))

   size=${#arreglo_mlb_equipo[@]}

   echo "ID_equipo,audiencia" > ../output/mlb_audiencia_year_$year.txt

   for (( i=0; i<$size; i++ )); 
   do 
      echo "${arreglo_mlb_equipo[$i]},${arreglo_mlb_audiencia[$i]}" >> ../output/mlb_audiencia_year_$year.txt
   done

   echo "Esta es la información encontrada"
   cat ../output/mlb_audiencia_year_$year.txt

fi
