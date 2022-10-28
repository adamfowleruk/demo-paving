#!/bin/sh

# See https://github.com/vandium-io/jwtgen
# install via `npm install -g jwtgen`
jwtgen -a RS256 -p jwtRS256.key -c "iss=testing@adamfowler.org" -e 3600 > annie.jwt
# jwtgen -a RS256 -p jwtRS256.key -c "user=annie" -e 3600 > annie.jwt
# jwtgen -a RS256 -p jwtRS256.key -c "user=joan" -e 3600 > joan.jwt
