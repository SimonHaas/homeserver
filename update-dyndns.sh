#!/usr/bin/env bash

[ ! -f ./.env ] &&
  echo '.env file is missing!' &&
  exit 1

source ./.env

# Exit if the RECORD_IDS array has no elements
[ ${#RECORD_IDS[@]} -eq 0 ] &&
  echo 'RECORD_IDS are missing!' &&
  exit 1

public_ip=$(curl -s http://checkip.amazonaws.com/)

local_ip=$(
  curl \
    --fail \
    --silent \
    -X GET \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    "https://api.digitalocean.com/v2/domains/${DOMAIN}/records/${RECORD_IDS[0]}" |
    grep -Eo '"data":".*?"' |
    grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"
)

# manual test
# curl \
#     --fail \
#     --silent \
#     -X GET \
#     -H "Content-Type: application/json" \
#     -H "Authorization: Bearer 3bdf2f8e5c614acb3daf87e13aef227436a29cc07be03691ff57811470b92726" \
#     "https://api.digitalocean.com/v2/domains/simonhaas.eu/records/283808266" |
#     grep -Eo '"data":".*?"' |
#     grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"

curl -X POST "https://gotify.simon-haas.eu/message?token=ACIU-n_GSe.xQLl" -F "title=update-dns.sh" -F "message=public_ip: ${public_ip}, local_ip: ${local_ip}"

# if the IPs are the same just exit
[ "$local_ip" == "$public_ip" ] && exit 0

for ID in "${RECORD_IDS[@]}"; do

  # --fail silently on server errors
  result=$(
    curl \
      --fail \
      --silent \
      -X PUT \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer ${ACCESS_TOKEN}" \
      -d "{\"data\": \"${public_ip}\"}" \
      "https://api.digitalocean.com/v2/domains/${DOMAIN}/records/${ID}"
  )

  curl -X POST "https://gotify.simon-haas.eu/message?token=ACIU-n_GSe.xQLl" -F "title=update-dns.sh" -F "message=updated to new ip ${public_ip}"

done
