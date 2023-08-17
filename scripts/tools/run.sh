#!/bin/bash

DIRECTORY="/home/examplecsv"
SCRIPT_NAME="loadCSV.sh"
MAX_RESTARTS=10

pm2 stop all
pm2 delete all
for file in "$DIRECTORY"/*".csv"; do
    if [ -f "$file" ]; then
        process_name="$$-b$(date +"%Y%m%d%H%M%S")"
        set -x
        pm2 start "$SCRIPT_NAME" --time --restart-delay 500 --name "$process_name" -- "${mi_dataset}" "${mi_tabla}" "$file" 
        sleep 1
    fi
done