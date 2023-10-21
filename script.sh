#!/bin/bash

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

if [[ "$1" = "KASM" ]]
then
  cd services/kasm
  sudo bash kasm_release/bin/$2
  cd ../..
  exit 0
fi

servicesEnv="$(printenv "$1")"

IFS=',' read -r -a services <<< "$servicesEnv"

for service in ${services[*]}
do
    cd services/$service
    docker compose $2 $3 $4 $5
    cd ../..
done
