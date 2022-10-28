# K8s production yaml files

These are all separated so that adopters can choose some API to publish and some to not.

Also separated so adopters can choose from a variety of ingress and database options, which may vary by IaaS provider.

Note: We'll start with prod, and then parameterise it for multiple environments.

## Working

- DONE Manage API service description
- DONE Manage API nodeport exposure on localhost:30001

Phase 1: Basic HATEOAS RESTful API sample
- DONE Istio exposure on GET /v1/manage with basic load balancer as per book
- DONE Add HATEOAS and create 'addresses' and 'address/name' endpoints
- DONE Ensure istio exposes these endpoints correctly, and that /v1 is added / rewritten to HATEOAS links
- SHOULD WORK Ensure /v1 and /v2 specifiers are working with specific named container versions

Phase 1a: Baseline pen test
- DONE Deploy port scan container instance and see what we can see on the local network
 - DONE Found a great tool for scanning for k8s vulns: https://github.com/darkbitio/mkit
 - DONE See also [k8s utilities - kubectl-mtb](../utilities/kubectl-mtb.md)
- DONE See what headers come back and if we need to remove any by default
 - DONE server, x-envoy-upstream-service-time, x-powered-by - reveal system info and version numbers - remove them at gateway via VirtualService rule (see k8s/ENV/APP/ingress-istio.yaml)
  - Note: after remove, server: istio-envoy still set. Maybe try set instead of remove?
 - etag? (not modified seems to be working well with this OOTB)

## TODOs

Phase 1b: Multiple ingress gateways / user types
- DONE TLS ingress only (prereqs/ingress-istio.yaml - Option 2)
 - Note: Bug in Istio redirect from http:80 to https:443 with AWS ELB - so best to set that on the IaaS layer
- DONE Authenticated vs unauthenticated users
- Force auth as the default for all URLs
- Build basic login endpoint that issues a jwt
- Unauthenticated login page redirect URL returned rather than just unauthorized (HATEOAS principle for auth endpoint discovery)
- View traffic in Kiali and Grafana

Phase 1c: Bring it up from scratch
- Fix this from Sonobuoy: Suggestion: add 'version' label to pod for Istio telemetry.
 - What is common to differentiation between apiVersion and appVersion and serviceVersion?
- Incorporate EKS terraform scripts into repo
- Ensure Terraform installs latest Istio, and supporting components required

Phase 2: Stack deployment
- Create backing postgres db with persistent volume claim (single instance fine for now) (Shared DB across two rest endpoints)
- Link rest endpoints to postgres
- Create postgres deployment and include in sample folder
- Create helm chart with hardcoded prod values
- Include Istio installation in deployment of whole stack

Phase 3: Flexibility
- Add demo / preprod / prod types and sizes for deployments (single/less instances, etc.)
 - Instance count multipliers?
- Publish helm chart somewhere other environments can get hold of it
- Test on additional K8S
 - TKGm on AWS for now (With ubuntu, ideally)
 - Stretch: Via TMC with TSM
 - Stretch: AKS on Azure
- Multiple OS base images? (E.g. amazon linux, alpine)
 - Move to distroless base images?: https://betterprogramming.pub/how-to-harden-your-containers-with-distroless-docker-images-c2abd7c71fdb
- Test terraform from nothing over and over again

Phase 4: Hardening
- Enforce TLS insteead of HTTP. Forward HTTP to HTTPS URL.
- TEST ME Default deny policy on network (k8s/ENV/prereqs/network-policy.yaml)
- Apply various best practices in k8s best practices book
- Prevent use of the default namespace
- See about applying Tanzu standard K8S base images that adhere to STIGs
- DONE npm lockfile
- npm package publishing, singing, and verification in Dockerfile
- NOTE: POD security policies are DEPRECATED!!! https://blog.aquasec.com/kubernetess-policy
- Apply hard maximum request limits
- Apply max resource limits
- Apply auto scaling rules with hard limits
- Apply minimum cypher suite, strength, and TLS versions
- Add 'latest' option (E.g. TLS v1.3 not v1.2, and ECIES not RSA4096)
- Apply anything else from NCSC cloud practices

Phase 5: Ease of use
- See the easiest way to package up a target env (E.g. via shell script to pick out right options?)

Phase 6: CI/CD
- GitHub Actions (imperitive) - how far can we go with it? (Safely/securely)
- Concourse (declarative) - Platform Control Plan rollout, CI, CD
- Ansible (imperitive) - Rough edges and best practices?
- Note: May require modularising our Terraform in its repo, and having a separate 'target env' repo linked to this
 - Perhaps a template for the target repo... repo...
- Ensure terraform doesn't stomp all over kubernetes auto scaling rules

Phase 7: Missing bits of tech
- S3 / Minio support
- RabbitMQ support
- DB migrations

Phase 8: Zero Trust
- Create separate cluster for app zero trust control plane
- Device trust score - browser agent ID, spamming IP addresses
- Traaffic trust - URL requested (common pen test patterns), request format/size, response content type
- Scanning tools. See: https://github.com/kubernetes-sigs/multi-tenancy/blob/master/benchmarks/kubectl-mtb/README.md#install-kyverno-or-gatekeeper-to-secure-the-cluster

Phase 9: High availability
- See prereqs/zones.txt
- Build in backup/restore of data plane
- Build in archiving of log files, metrics, etc
- Build in checks to ensure what is running is what was scripted


