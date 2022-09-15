#!/bin/bash

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

if [[ "$1" = "SERVICES" ]]
then
  servicesEnv="${SERVICES}"
elif [[ "$1" = "KASM" ]]
then
  cd services/kasm
  sudo bash kasm_release/bin/start
  cd ../..
  exit 0
else
  servicesEnv="${INFRASTRUCTURE}"
fi

IFS=',' read -r -a services <<< "$servicesEnv"

for service in ${services[*]}
do
    cd services/$service
    docker compose $2 $3
    cd ../..
done
