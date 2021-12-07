# Delivery Integration

This folder shows an example Concourse CI pipeline to integrate a set of base container images,
a set of known app patterns, and a set of target K8S environments, and test out the automated
build pipelines should any base version change.

## User Stories

The following user stories are what we are optimising for with this sample pattern:-

### User Story 1: The developer is my customer

```text
[Who]   As a developer
[What]  I need automation to build my app which uses standard patterns for me
[Value] In order to not have to learn k8s primitives or live my life editing YAML files
```

### User story 2: As a product manager

```text
[Who]   As a (software) product manager (NOT project manager!)
[What]  I need continuous integration to automate the merging of the latest versions of all software, including OS base images, app frameworks
[Value] So my developers can concentrate on adding new features, not keeping up with CVEs
```

### User story 3: As a DevOps platform engineer

```text
[Who]   As a DevOps platform engineer
[What]  I need to provide a 'container build as a service' to my agile development teams
[Value] So they don't have to reinvent the wheel for each software product, and so I know we have security best practice ingrained across all products
```

## Technology choices

I have made the following base tech choices for this example using opensource componentry:-

- Automation: Concourse CI - Concourse is great for declarative, rather than imperative, integration and is well suited for 'hands off' automation should any of a multitude of base dependencies changes
- Automation runtime environment: AWS EKS (Elastic Kubernetes Service) - Readily available for anyone to test on. Also used for a shared services cluster for my team already (So the environment exists!)
- Base images: RHEL for containers, SUSE, Ubuntu - All commonly used. Ubuntu also meets DISA STIGs for container images
- App frameworks: ReactJS + Python Flask + Postgresql DB - A common three tier pattern that new developers will be familiar with early in their careers. I may add more runtimes in future (E.g. Java Spring Boot, C# .NET Core)
- Container registry, scanning, signing: Harbor - Opensource, used already in my shared services cluster (so already available!). Supports replication too, useful for pushing through data diodes in secure environments. Includes the Clair and Trivy scanning options, and supports helm charts and signing images
- Target app test environment: AWS EKS - Consistency with the above. May add more K8S in future to show multiple target env tests
- Automated pen tests: Sonobuoy - (Stretch goal) Used to validate the security of K8S installs. Can have custom checks included. Defaults to CIS Benchmarks for K8S.

## Supported tech choices

If support is required from a commercial org, below are the products that can be used from VMware on this:-

- Automation: Concourse CI is supported by VMware. Could also use Tekton within Tanzu App Platform if required. Tanzu Build Service can be used to take common app patterns and generate container images too.
- Automation Runtime Environment: VMware Tanzu Kubernetes Grid (Supports multi cloud)
- Base images: VMware provides both PhotonOS (as used within VMware ESXi) and Ubuntu base images. Others are supported
- App frameworks: VMware provides support for the java runtime, tomcat, and spring boot. Tanzu Build Service supports a myriad of other target app platforms too.
- Container registry, scanning, signing: VMware supports Harbor as part of the Tanzu Kubernetes Grid license
- Target app test environment: Tanzu Kubernetes Grid. Could also have a more PaaS like experience with Tanzu App Platform on top of this or anyones K8S runtime
- Automated pen tests: Sonobuoy is a VMware project, supported as part of Tanzu Essentials for Kubernetes (or as part of Standard/Advanced licenses) or third party scanners are available

## Running the sample

First install concourse via helm:-

```sh
kubectl create namespace concourse
helm repo add concourse https://concourse-charts.storage.googleapis.com/
helm install my-concourse concourse/concourse \
  --namespace concourse \
  --set 'concourse.web.externalUrl=https://concourse.shared.12factor.xyz' \
  --set 'concourse.web.kubernetes.namespacePrefix=ci-release-' \
  --set 'concourse.web.auth.mainTeam.localUser=ciuser' \
  --set 'secrets.localUsers=MYUSERNAME:SOMESUPERSECUREPASSWORD' \
  --set 'persistence.worker.size=256Gi'
```

Then I manually applied my istio config for concourse:-

```sh
kubectl apply -f ../../../k8s/production/ingress/concourse.yaml
```

Make sure you reapply the istio config for the shared pre-sales environment (this defines my gateway, cert issuer, etc.)

 - NOTE THIS IS ONLY AVAILABLE INTERNALLY TO VMWARE. CONFIGURE YOUR ISTIO GATEWAY AS YOU WISH

Note I didn't use the below as I keep my istio config separate, but you could:-

```sh
  --set 'concourse.ingress.enabled=true' \
  --set 'concourse.ingress.hosts=concourse.shared.12factor.xyz' \
```


Now login to fly and run the pipeline:-

```sh
fly --target shared login --team-name main --concourse-url https://concourse.shared.12factor.xyz
fly -t shared sync
fly -t shared set-pipeline -p app-pipeline \
  -c ./concourse-pipeline.yaml \
  --var image-repo-name=harbor.shared.12factor.xyz/HARBORPROJECTNAME \
  --var registry-username=CIUSER \
  --var registry-password=CIPASSWORD
```