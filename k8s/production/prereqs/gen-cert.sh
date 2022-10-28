#!/bin/sh
# See ingress-istio.yaml and its TLS configuration

# Generate a route certificate and store somewhere super safe (HSM ideally)
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 -subj '/O=Big App Inc./CN=adamfowler.org' -keyout adamfowler.org.key -out adamfowler.org.crt

# Certificate signing request for child cert
openssl req -out bigapp.adamfowler.org.csr -newkey rsa:4096 -nodes -keyout bigapp.adamfowler.org.key -subj "/CN=bigapp.adamfowler.org/O=bigapp organization"
# Generate of child cert
openssl x509 -req -days 365 -CA adamfowler.org.crt -CAkey adamfowler.org.key -set_serial 0 -in bigapp.adamfowler.org.csr -out bigapp.adamfowler.org.crt
