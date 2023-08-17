# Datagen

Programa que genera datos de test siguiendo la estructura

```json
[
    {"name": "Nombre", "type": "STRING"},
    {"name": "Apellido", "type": "STRING"},
    {"name": "Edad", "type": "INTEGER"},
    {"name": "Nacimiento", "type": "DATE"},
    {"name": "Altura", "type": "INTEGER"},
    {"name": "Sexo", "type": "STRING"}
]
```


Ejemplo: Se generan `3`  ficheros de `20`  registros cada uno en la carpeta `./tmp/` 

```bash
rm -rf ./tmp/*
mkdir -p tmp
node createUserRecords.js 30 20 ./tmp/
```