# Utiliza la imagen base
FROM google/cloud-sdk:latest

# Actualiza los repositorios y instala curl
RUN apt-get update && apt-get install -y curl

# Instala el servidor SSH
RUN apt-get install -y openssh-server

# Configura el servidor SSH y crea un usuario
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'PermitUserEnvironment yes' >> /etc/ssh/sshd_config

# Expon el puerto 22 para SSH
EXPOSE 22

# Descarga e instala Node.js 18
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Instala pm2 globalmente usando npm
RUN npm install -g pm2

# Instalación del programa de generación de ficheros
COPY ./dataGen /app/dataGen
WORKDIR /app/dataGen
RUN npm install

WORKDIR /home

# Inicia el servidor SSH al ejecutar el contenedor
CMD ["/usr/sbin/sshd", "-D"]
