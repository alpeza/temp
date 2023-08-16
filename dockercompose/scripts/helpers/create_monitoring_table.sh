#!/bin/bash

nombre_dataset="holi"
nombre_tabla="monitorisasion"

# Verificar si el dataset existe en BigQuery
if ! bq show "$nombre_dataset" >/dev/null 2>&1; then
  echo "El dataset $nombre_dataset no existe en BigQuery. Creando el dataset..."
  bq mk --dataset "$nombre_dataset"
  echo "El dataset $nombre_dataset se ha creado en BigQuery."
fi

# Verificar si la tabla existe en BigQuery
if ! bq show "$nombre_dataset.$nombre_tabla" >/dev/null 2>&1; then
  echo "La tabla $nombre_dataset.$nombre_tabla no existe en BigQuery. Creando la tabla..."
  bq query --use_legacy_sql=false <<EOF
  CREATE TABLE IF NOT EXISTS \`$nombre_dataset.$nombre_tabla\` (
    \`idfiles\` INT64 NOT NULL,
    \`name\` STRING,
    \`hash\` STRING,
    \`status\` STRING,
    \`log\` STRING,
    \`records\` INT64,
    \`init\` TIMESTAMP,
    \`end\` TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    \`reason\` STRING
  );
EOF
  echo "La tabla $nombre_dataset.$nombre_tabla se ha creado en BigQuery."
else
  echo "La tabla $nombre_dataset.$nombre_tabla ya existe en BigQuery."
fi
