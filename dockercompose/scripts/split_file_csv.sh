#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Uso: $0 <ruta_archivo_csv> <total_registros_por_bloque> <path_salida>"
  exit 1
fi

ruta_archivo_csv=$1
total_registros_por_bloque=$2
path_salida=$3

# Verificar si el archivo CSV existe
if [ ! -f "$ruta_archivo_csv" ]; then
  echo "El archivo CSV $ruta_archivo_csv no existe."
  exit 1
fi

# Verificar si el directorio de salida existe y borrar su contenido si es necesario
if [ -d "$path_salida" ]; then
  echo "Borrando el contenido del directorio $path_salida..."
  rm -rf "$path_salida"/*
else
  echo "Creando el directorio de salida $path_salida..."
  mkdir -p "$path_salida"
fi

# Dividir el archivo CSV en bloques más pequeños
echo "Dividiendo el archivo CSV $ruta_archivo_csv en bloques de $total_registros_por_bloque registros..."
split --lines="$total_registros_por_bloque" --numeric-suffixes "$ruta_archivo_csv" "$path_salida/split_"

echo "División completada. Los archivos divididos se encuentran en el directorio $path_salida."
