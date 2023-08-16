mi_dataset="un_dataset"
mi_tabla="tabla1"
ruta_esquema="/home/datasets/personas.json"
total_registros_por_bloque=100
jobs_paralelo=5
path_salida="/home/scripts/splited"
rutafichero="/home/datasets/personas.csv"
report_path="/home/scripts/report.csv"

printStage(){
    echo " "
    echo "    \_> $1"
    echo "    .........................................................."
}

# 0.- Splitando
printStage "STAGE 0: Splitando"
#./split_file_csv.sh "$rutafichero" $total_registros_por_bloque "$path_salida"

# 1.- Creamos un dataset y una tabla a la que le asociamos el schema
printStage "STAGE 1: Creando dataset"
./create_table.sh "$mi_dataset" "$mi_tabla" "$ruta_esquema"

# 2.- Cargamos un fichero csv
printStage "STAGE 2: Cargando ficheros CSV"
./process_folder.sh "$mi_dataset" "$mi_tabla" "$path_salida" $jobs_paralelo "$report_path"


