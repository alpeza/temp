#!/bin/bash

#if [ $# -ne 3 ]; then
#  echo "Carga en BigQuery un determinado fichero. Uso: $0 <nombre_dataset> <nombre_tabla> <ruta_archivo_csv>"
#  exit 1
#fi

nombre_dataset=$1
nombre_tabla=$2
ruta_archivo_csv=$3

bq load --source_format=CSV --dataset_id="$nombre_dataset"  "$nombre_tabla" "$ruta_archivo_csv"; bqrc=$?
echo "Código de retorno: $bqrc"
exit $bqrc
