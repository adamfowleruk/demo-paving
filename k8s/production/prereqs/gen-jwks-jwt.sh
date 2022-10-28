#!/bin/sh
# Generate a pub/priv key for authentication as per JWKS
# Then generate the JWKS from the public key
# Then generate a valid JWT token for the JWKS service

ssh-keygen -t rsa -b 4096 -m PEM -f jwtRS256.key
# Don't add passphrase
openssl rsa -in jwtRS256.key -pubout -outform PEM -out jwtRS256.key.pub

# For base64: cat jwtRS256.key | base64

SHA1SUM=`sha1sum jwtRS256.key.pub`

# Note: I gave up doing this in a script for now...

# Now convert the PEM pub key representation via here:-
# https://8gwifi.org/jwkconvertfunctions.jsp
