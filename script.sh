#!/bin/bash

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

domain="${DOMAIN:-default_value}"

servicesEnv="${SERVICES:-default_value}"
IFS=',' read -r -a services <<< "$servicesEnv"

for service in ${services[*]}
do
    cd services/$service
    #TODO cp .env.example .env if no .env exists
    #TODO prepare .env with domain
    docker-compose $1 $2 $3
    cd ../..
done

customServicesEnv="${CUSTOM_SERVICES:-default_value}"
IFS=',' read -r -a customServices <<< "$customServicesEnv"

for service in ${customServices[*]}
do
    cd custom_services/$service
    #TODO cp .env.example .env if no .env exists
    #TODO prepare .env with domain
    docker-compose $1 $2 $3
    cd ../..
done