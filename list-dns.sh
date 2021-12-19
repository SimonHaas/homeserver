#!/usr/bin/env bash

source ./.env

response=$(curl \
  --silent \
  -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  "https://api.digitalocean.com/v2/domains/$DOMAIN/records")

echo $response | grep -Eo '"id":\d*|"type":"\w*"|"data":".*?"'