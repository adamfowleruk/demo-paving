# Apply new domain to just tap-ui install


Modify these lines only (leave other sub items the same!):-

```yaml
tap_gui:
  app_config:
    app:
      # Uses istio, not contour
      baseUrl: https://tap-gui.tap10istio.12factor.xyz
    backend:
      baseUrl: https://tap-gui.tap10istio.12factor.xyz
      cors:
        origin: https://tap-gui.tap10istio.12factor.xyz
```

```sh
tanzu package installed update tap -p tap.tanzu.vmware.com -v 1.0.0 --values-file tap-values-full-istio.yaml -n tap-install
```