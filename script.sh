#!/bin/bash

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

if [[ "$1" = "SAVE_BACKUP" ]]
then
  servicesEnv="${SAVE_BACKUP}"
elif [[ "$1" = "KASM" ]]
then
  cd services/kasm
  sudo bash kasm_release/bin/$2
  cd ../..
  exit 0
else
  servicesEnv="${ACTIVE_SERVICES}"
fi

IFS=',' read -r -a services <<< "$servicesEnv"

for service in ${services[*]}
do
    cd services/$service
    docker compose $2 $3 $4 $5
    cd ../..
done

# TODO option ALL to start everything
# TODO refactor into functions
