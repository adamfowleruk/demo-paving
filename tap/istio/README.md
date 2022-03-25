# Istio for TAP

This repo constains configuration to apply to a default TAP install which converts
it from using Contour L7 ingress only, to using Istio L7 ingress and mTLS between
TAP components within the cluster, and for it's knative runtime for apps.

## Why are you doing this?

To see how easy it is to have our whole TAP platform use Istio, including allowing
apps to use it which are built with TAP.

## The Plan

Start small, think big.

1. DONE Install Istio into the usual istio namespace alongside Contour without breaking anything, using cert-manager and tls cert provisioning
2. DONE Copy over Contour ingress capabilities for tap-gui on new domain
3. Ensure anything behind TAP gui itself is communicated with using mTLS from istio, transparently if possible (nothing allegedly...)
4. Disable egress for the tap-gui namespace to ensure there are no external comms
5. Enable istio ingress TLS with cert