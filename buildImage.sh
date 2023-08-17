docker build -t gutils .
docker compose stop 
docker compose up -d 
docker exec -it temp-bq-1 bash