# ADSB full stack Helm Chart

## Installation


```sh
kubectl create namespace adsb
helm repo add adamf https://harbor.shared.12factor.xyz/
helm install my-adsb adamf/adsb-fullstack \
  --namespace adsb 
```

This instantiates the RabitMQ Operator but no users. It also isntantiates the Redis
secret for access with name DEPLOYMENT-redis as an Opaque secret with password in the
'redis-password' key.

The redis server is the service 'DEPLOYMENT-redis-headless' on port tcp-redis (6379).

