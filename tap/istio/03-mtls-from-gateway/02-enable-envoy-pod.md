# Enable envoy auto injection for TAP GUI

```sh
kubectl label namespace tap-gui istio-injection=enabled --overwrite
```

Now don't forget to reinstantiate all pods...

```sh
kubectl -n tap-gui delete pod server-556659d775-z2s4q 
```

Note: Your pod name may be different.

Pod will be recreated with an envoy sidecar:-

```sh
kubectl -n tap-gui get pods

NAME                      READY   STATUS    RESTARTS   AGE
server-556659d775-6jbdl   2/2     Running   0          43s
```

Note the 2 of 2 in the above.
