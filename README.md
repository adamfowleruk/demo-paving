# demo-paving

Paving for different platforms for the demo-node-apis project and supporting infrastructure.


## Scenario

I have a set of custom developed APIs and web applications which use them. I also
have the backing data services. I can choose to deploy some of these applications,
and not others. I can potentially blend them with other custom apps or SaaS components.

As the developer of such an app, I need to provide my apps and their containerised formats
in a way that can be flexibly integrated with a variety of K8S offerings, clouds, versions,
and networking and policy options. That is provided by the demo-node-apis project.

As the deployer of this technology, I need to do so in a way that fits with my own organisations'
policies and technology choices. I don't want to be forced into lowering my security
posture or adopting a particular technology for storage, networking, data services etc. just
because of the way some of those containers have been built.

As a deployer I need a set of known good, in-policy, configurations for these containerised
apps, their versions, and my choice of data services and ingress. This is provided by this
demo-paving repository.

## This repository

This repository showcases IaaS setup in terraform whch can be executed by a range of
CI and CD tools. Concourse shall be shown as an example initially.

This repository also pushes the same set of apps with a consistent technology stack
and configuration to a variety of K8S runtimes on a variety of cloud platforms.
They are then tested and verified as compliant with my technology choices, policy,
and standard NCSC and CIS cloud guidance.

# License and Copyright

All Copyright 2021 Adam Fowler. Licensed under the Apache-2.0 license.
