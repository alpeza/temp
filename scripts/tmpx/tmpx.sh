# Nombre del proceso PM2
process_name="mi-aplicacion"



# Arrancar el proceso de PM2
#pm2 start --name "$process_name" --no-autorestart  -- proc.sh
pm2 stop all
pm2 delete all
pm2 start ecosystem.config.js 
pm2 monit