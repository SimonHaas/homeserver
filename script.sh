#!/bin/bash

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

if [[ "$1" = "SAVE_BACKUP" ]]
then
  servicesEnv="${SAVE_BACKUP}"
elif [[ "$1" = "ACTIVE_SERVICES" ]]
then
  servicesEnv="${ACTIVE_SERVICES}"
elif [[ "$1" = "KASM" ]]
then
  cd services/kasm
  sudo bash kasm_release/bin/$2
  cd ../..
  exit 0
else
  echo 'not supported, run one of the following (with options like docker compose):'
  echo './script.sh ACTIVE_SERVICES up -d'
  echo './script.sh SAVE_BACKUP stop'
  echo 'OR:'
  echo './script.sh KASM start'
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
