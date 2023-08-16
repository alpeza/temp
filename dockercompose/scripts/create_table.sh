#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Uso: $0 <nombre_dataset> <nombre_tabla> <ruta_esquema_json>"
  exit 1
fi

nombre_dataset=$1
nombre_tabla=$2
ruta_esquema_json=$3

# Verificar si el archivo JSON de esquema existe
if [ ! -f "$ruta_esquema_json" ]; then
  echo "El archivo de esquema JSON $ruta_esquema_json no existe."
  exit 1
fi

# Verificar si el dataset ya existe en BigQuery
if ! bq show "$nombre_dataset" >/dev/null 2>&1; then
  echo "Creando el dataset $nombre_dataset en BigQuery..."
  bq mk --dataset "$nombre_dataset"
fi

# Verificar si la tabla ya existe en BigQuery
if bq show "$nombre_dataset.$nombre_tabla" >/dev/null 2>&1; then
  echo "La tabla $nombre_dataset.$nombre_tabla ya existe en BigQuery."
  exit 1
fi

# Crear la tabla en BigQuery utilizando el archivo JSON de esquema
echo "Creando la tabla $nombre_dataset.$nombre_tabla en BigQuery..."
bq mk --table "$nombre_dataset.$nombre_tabla" "$ruta_esquema_json"

echo "Tabla creada exitosamente en BigQuery."
