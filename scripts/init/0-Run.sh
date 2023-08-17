set -x
#0.- Creación en BigQuery de la tabla donde se van a cargar los datos
./1-CreaTabla.sh "$mi_dataset" "$mi_tabla" "$ruta_esquema"

#1.- Se crean 30 ficheros CSV con 20 registros de ejemplo en la carpeta 
rm -rf "$ruta_ficheros_temporales_para_cargar"
mkdir -p "$ruta_ficheros_temporales_para_cargar"
node /app/dataGen/createUserRecords.js 2 20 "$ruta_ficheros_temporales_para_cargar"
ls "$ruta_ficheros_temporales_para_cargar"
