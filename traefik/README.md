``` shell
#extract certificate from acme.json to .crt
cat acme.json | jq -r '.Certificates[] | select(.Domain.Main=="*.<DOMAIN>") | .Certificate' | base64 -d > *.<DOMAIN>.crt
#extract private key from acme.json to .key
cat acme.json | jq -r '.Certificates[] | select(.Domain.Main=="*.<DOMAIN>") | .Key' | base64 -d > *.<DOMAIN>.key
```