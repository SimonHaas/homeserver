# FitTrackee
https://github.com/SamR1/FitTrackee
https://samr1.github.io/FitTrackee/

cp ./docker-fittrackee/.env.example ./docker-fittrackee/.env
    set FITTRACKEE_LOG_DIR=/logs
docker compose up -d
docker compose exec fittrackee scripts/migrate.sh
docker compose restart fittrackee
register new account
docker-compose exec fittrackee scripts/set-admin.sh $(USERNAME)