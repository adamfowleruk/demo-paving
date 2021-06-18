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
- Add HATEOAS and create 'addresses' and 'address/name' endpoints
- Ensure istio exposes these endpoints correctly, and that /v1 is added / rewritten to HATEOAS links
- Ensure /v1 and /v2 specifiers are working with specific named container versions

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


Phase 4: Hardening
- Apply various best practices in k8s best practices book
- See about applying Tanzu standard K8S base images that adhere to STIGs
- npm lockfile
- npm package publishing, singing, and verification in Dockerfile

Phase 5: Ease of use
- See the easiest way to package up a target env (E.g. via shell script to pick out right options?)

Phase 6: CI/CD
- GitHub Actions - how far can we go with it? (Safely/securely)

Phase 7: Missing bits of tech
- S3 / Minio support
- RabbitMQ support
- DB migrations