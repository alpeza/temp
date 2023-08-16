#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Uso: $0 <nombre_dataset> <nombre_tabla> <ruta_archivo_csv>"
  exit 1
fi

nombre_dataset=$1
nombre_tabla=$2
ruta_archivo_csv=$3

# Verificar si el archivo CSV existe
if [ ! -f "$ruta_archivo_csv" ]; then
  echo "El archivo CSV $ruta_archivo_csv no existe."
  exit 1
fi

# Verificar si la tabla existe en BigQuery
if ! bq show "$nombre_dataset.$nombre_tabla" >/dev/null 2>&1; then
  echo "La tabla $nombre_dataset.$nombre_tabla no existe en BigQuery."
  exit 1
fi

# Cargar el archivo CSV en la tabla de BigQuery con la opción --append para agregar los nuevos datos
echo "Cargando $ruta_archivo_csv en la tabla $nombre_dataset.$nombre_tabla en BigQuery..."
bq load --source_format=CSV "$nombre_dataset.$nombre_tabla" "$ruta_archivo_csv"

echo "Carga completada."
