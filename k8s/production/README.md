# K8s production yaml files

These are all separated so that adopters can choose some API to publish and some to not.

Also separated so adopters can choose from a variety of ingress and database options, which may vary by IaaS provider.

Note: We'll start with prod, and then parameterise it for multiple environments.

## Working

- DONE Manage api service description
- DONE Manage API nodeport exposure on localhost:30001

## TODOs

Phase 1: Basic HATEOAS RESTful API sample
- DONE Istio exposure on GET /v1/manage with basic load balancer as per book
- DONE Add HATEOAS and create 'addresses' and 'address/name' endpoints
- DONE Ensure istio exposes these endpoints correctly, and that /v1 is added / rewritten to HATEOAS links
- SHOULD WORK Ensure /v1 and /v2 specifiers are working with specific named container versions

Phase 1a: Baseline pen test
- Deploy port scan container instance and see what we can see on the local network
- See what headers come back and if we need to remove any by default

Phase 1b: Multiple ingress gateways / user types
- Authenticated vs unauthenticated users
- Unauthenticated redirect URL

Phase 1c: Bring it up from scratch
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
- Test on Docker Desktop, ECS, AKS, GKE
- Multiple OS base images? (E.g. amazon linux, alpine)
- Test terraform from nothing over and over again

Phase 4: Hardening
- Enforce TLS insteeadof HTTP. Forward HTTP to HTTPS URL.
- Apply various best practices in k8s best practices book
- See about applying Tanzu standard K8S base images that adhere to STIGs
- DONE npm lockfile
- npm package publishing, singing, and verification in Dockerfile
- Apply hard maximum request limits
- Apply max resource limits
- Apply auto scaling rules with hard limits
- Apply minimum cypher suite, strength, and TLS versions
- Add 'latest' option (E.g. TLS v1.3 not v1.2, and ECIES not RSA4096)
- Apply anything else from NCSC cloud practices

Phase 5: Ease of use
- See the easiest way to package up a target env (E.g. via shell script to pick out right options?)

Phase 6: CI/CD
- GitHub Actions - how far can we go with it? (Safely/securely)

Phase 7: Missing bits of tech
- S3 / Minio support
- RabbitMQ support
- DB migrations

Phase 8: Zero Trust
- Create separate cluster for app zero trust control plane
- Device trust score - browser agent ID, spamming IP addresses
- Traaffic trust - URL requested (common pen test patterns), request format/size, response content type