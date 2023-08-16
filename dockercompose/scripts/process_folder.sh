#!/bin/bash

if [ $# -ne 5 ]; then
  echo "Uso: $0 <nombre_dataset> <nombre_tabla> <carpeta_csvs> <numero_tasks> <report_path>"
  exit 1
fi

nombre_dataset=$1
nombre_tabla=$2
carpeta_csvs=$3
numero_tasks=$4
report_path=$5

# Verificar si la carpeta CSVs existe
if [ ! -d "$carpeta_csvs" ]; then
  echo "La carpeta $carpeta_csvs no existe."
  exit 1
fi

# Verificar si la tabla existe en BigQuery
if ! bq show "$nombre_dataset.$nombre_tabla" >/dev/null 2>&1; then
  echo "La tabla $nombre_dataset.$nombre_tabla no existe en BigQuery."
  exit 1
fi

# Borrar el contenido del archivo de reporte si ya existe
if [ -f "$report_path" ]; then
  > "$report_path"
fi

# Lista de archivos CSV en la carpeta
csv_files=$(find "$carpeta_csvs" -maxdepth 1 -type f)

# Función para ejecutar el comando load_csv_to_table.sh y generar el registro en el reporte
function execute_load {
  archivo_csv="$1"
  echo "Ejecutando carga $1"
  inicio=$(date +%s)
  ./load_csv_to_table.sh "$nombre_dataset" "$nombre_tabla" "$archivo_csv"
  fin=$(date +%s)
  tiempo_ejecucion=$((fin - inicio))
  total_registros=$(wc -l < "$archivo_csv")
  echo "$archivo_csv,$inicio,$fin,$tiempo_ejecucion,$total_registros" >> "$report_path"
}


function process_files_in_parallel {
  local csv_files="$1"
  local numero_tasks="$2"
  # Convertir la variable csv_files en un array
  IFS=$'\n' read -rd '' -a files_array <<< "$csv_files"
  # Ejecutar el comando execute_load en paralelo para cada archivo CSV
  for archivo_csv in "${files_array[@]}"; do
    execute_load "$archivo_csv" &
    (( count++ ))
    if (( count % numero_tasks == 0 )); then
      wait
    fi
  done
  wait
}


# Ejecutar las tareas en paralelo utilizando el número de tasks especificado
echo "Iniciando carga de archivos CSV en paralelo..."
process_files_in_parallel "$csv_files" "$numero_tasks"
echo "Carga completada."

# Ordenar el archivo de reporte por nombre de archivo CSV
#sort -o "$report_path" "$report_path"
