# Istio Envoy everywhere

Here we inject the istio-proxy (Envoy) into every TAP namespace and regenerate every POD so envoy is enabled.

We are NOT enforcing incoming TLS yet, just using this so we can visualise everything in Kiali.

## Disable kapp package install reconciliation

If you dont do this, kapp-controller will come in behind you and reconfigure all pods and remove istio-proxy (envoy).

```sh
kubectl edit -n tap-install tap
# VI launches, add this:-
...
spec:
  paused: true
...
```
Save and exit the above.

WARNING: This has to be done for EVERY TAP package, not just TAP. I avoided touching cert-manager, 
secretgen-controller, and contour (aka tanzu-system-ingress) themselves.

You can view all available packages by executing:-

```sh
kubectl get packageinstall -A
```

Note that the package names and kubernetes namespace names don't always align.

## Label all namespaces

```sh
kubectl label namespace tap-gui istio-injection=enabled --overwrite
kubectl label namespace accelerator-system istio-injection=enabled --overwrite
kubectl label namespace alv-convention istio-injection=enabled --overwrite
kubectl label namespace api-portal istio-injection=enabled --overwrite
kubectl label namespace app-live-view istio-injection=enabled --overwrite
kubectl label namespace build-service istio-injection=enabled --overwrite
kubectl label namespace cartographer-system istio-injection=enabled --overwrite
kubectl label namespace conventions-system istio-injection=enabled --overwrite
kubectl label namespace developer-conventions istio-injection=enabled --overwrite
kubectl label namespace flux-system istio-injection=enabled --overwrite
kubectl label namespace image-policy-system istio-injection=enabled --overwrite
kubectl label namespace knative-eventing istio-injection=enabled --overwrite
kubectl label namespace knative-serving istio-injection=enabled --overwrite
kubectl label namespace knative-sources istio-injection=enabled --overwrite
kubectl label namespace kpack istio-injection=enabled --overwrite
kubectl label namespace learning-center-guided-ui istio-injection=enabled --overwrite
kubectl label namespace learning-center-guided-w02 istio-injection=enabled --overwrite
kubectl label namespace learningcenter istio-injection=enabled --overwrite
kubectl label namespace metadata-store istio-injection=enabled --overwrite
kubectl label namespace scan-link-system istio-injection=enabled --overwrite
kubectl label namespace service-bindings istio-injection=enabled --overwrite
kubectl label namespace services-toolkit istio-injection=enabled --overwrite
kubectl label namespace source-system istio-injection=enabled --overwrite
kubectl label namespace spring-boot-convention istio-injection=enabled --overwrite
kubectl label namespace stacks-operator-system istio-injection=enabled --overwrite
kubectl label namespace tanzu-package-repo-global istio-injection=enabled --overwrite
kubectl label namespace tap-telemetry istio-injection=enabled --overwrite
kubectl label namespace tekton-pipelines istio-injection=enabled --overwrite
kubectl label namespace triggermesh istio-injection=enabled --overwrite
kubectl label namespace vmware-sources istio-injection=enabled --overwrite
```

## Regenerate pods

Now we kick all the pods in all the above namespaces in order for istio to regenerate the pod with envoy included.

```sh
kubectl delete --all pod -n tap-gui
kubectl delete --all pod -n accelerator-system
kubectl delete --all pod -n alv-convention
kubectl delete --all pod -n api-portal
kubectl delete --all pod -n app-live-view
kubectl delete --all pod -n build-service
kubectl delete --all pod -n cartographer-system
kubectl delete --all pod -n conventions-system
kubectl delete --all pod -n developer-conventions
kubectl delete --all pod -n flux-system
kubectl delete --all pod -n image-policy-system
kubectl delete --all pod -n knative-eventing
kubectl delete --all pod -n knative-serving
kubectl delete --all pod -n kpack
kubectl delete --all pod -n learning-center-guided-ui
kubectl delete --all pod -n learningcenter
kubectl delete --all pod -n metadata-store
kubectl delete --all pod -n scan-link-system
kubectl delete --all pod -n service-bindings
kubectl delete --all pod -n services-toolkit
kubectl delete --all pod -n source-system
kubectl delete --all pod -n spring-boot-convention
kubectl delete --all pod -n stacks-operator-system
kubectl delete --all pod -n tap-telemetry
kubectl delete --all pod -n tekton-pipelines
kubectl delete --all pod -n triggermesh
kubectl delete --all pod -n vmware-sources
```

You should now see all pods will restart with two containers - the normal container, and the istio-proxy (envoy) container

```sh
kubectl get pod -A
```

## Visualise traffic in Kiali

```sh
istioctl dashboard kiali
```

1. Go to Graph view
1. From the display drop down, enable "Security" icons
1. Select all namespaces
1. Select the versioned app view
1. Change timings to last 10 minutes, every 15 seconds
1. Hit various pages on tap-gui from your browser, and the /app-live-view URL, learning center workshops, and visualise the results in kiali