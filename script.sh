#!/bin/bash

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

servicesEnv="${SERVICES:-default_value}"
IFS=',' read -r -a services <<< "$servicesEnv"

for service in ${services[*]}
do
    cd services/$item
    docker-compose $1 $2 $3
    cd ..
done
