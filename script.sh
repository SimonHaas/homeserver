#!/bin/bash

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

domain="${DOMAIN}"

servicesEnv="${SERVICES}"
IFS=',' read -r -a services <<< "$servicesEnv"

for service in ${services[*]}
do
    cd services/$service
    docker compose $1 $2 $3
    cd ../..
done

customServicesEnv="${CUSTOM_SERVICES}"
IFS=',' read -r -a customServices <<< "$customServicesEnv"

for service in ${customServices[*]}
do
    cd custom_services/$service
    docker compose $1 $2 $3
    cd ../..
done