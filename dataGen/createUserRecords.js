const { faker } = require('@faker-js/faker');
//const createCsvWriter = require('csv-writer').createObjectCsvWriter;

const fs = require('fs');
const path = require('path');

const schema = [
    {"name": "Nombre", "type": "STRING"},
    {"name": "Apellido", "type": "STRING"},
    {"name": "Edad", "type": "INTEGER"},
    {"name": "Nacimiento", "type": "DATE"},
    {"name": "Altura", "type": "INTEGER"},
    {"name": "Sexo", "type": "STRING"}
];

const generateRandomRecord = () => {
    const record = {};
    for (const field of schema) {
        switch (field.type) {
            case 'STRING':
                record[field.name] = faker.person.firstName();
                break;
            case 'INTEGER':
                record[field.name] = faker.number.int();
                break;
            case 'DATE':
                record[field.name] = faker.date.past().toISOString().split('T')[0];
                break;
        }
    }
    return record;
};

const numFiles = process.argv[2] || 1;
const numRecordsPerFile = process.argv[3] || 10;
const outputPath = process.argv[4] || './output';

generateCSVFiles(numFiles, numRecordsPerFile, outputPath);

function generateCSVFiles(numFiles, numRecordsPerFile, outputPath) {
    if (!fs.existsSync(outputPath)) {
        fs.mkdirSync(outputPath, { recursive: true });
    }

    for (let fileIndex = 0; fileIndex < numFiles; fileIndex++) {
        const csvFilePath = path.join(outputPath, `registros_${fileIndex + 1}.csv`);
        const fileStream = fs.createWriteStream(csvFilePath);

        for (let recordIndex = 0; recordIndex < numRecordsPerFile; recordIndex++) {
            const randomRecord = generateRandomRecord();
            const recordLine = Object.values(randomRecord).join(',') + '\n';
            fileStream.write(recordLine);
        }

        fileStream.end();
    }

    console.log(`Se generaron ${numFiles} archivos CSV en la ruta ${outputPath}`);
}
