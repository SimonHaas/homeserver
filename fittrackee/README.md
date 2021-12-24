# initial startup
git clone https://github.com/SamR1/FitTrackee.git repo
docker-compose build
docker-compose up -d fittrackee
docker-compose exec fittrackee docker/init-database.sh
docker-compose restart fittrackee
docker-compose exec -d fittrackee docker/run-workers.sh

# subsequent startups
docker-compose up -d

# make translated to shell commands
## make docker-build-all
docker-compose build

## make docker-run-all
docker-compose up -d fittrackee
docker-compose exec -d fittrackee docker/run-workers.sh

## make docker-init
docker-compose exec fittrackee docker/init-database.sh
docker-compose restart fittrackee
docker-compose exec -d fittrackee docker/run-workers.sh