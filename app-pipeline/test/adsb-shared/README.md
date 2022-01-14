# ADSB images pipeline

This pipeline takes the constituent apps that make up the ADSB Aircraft
Tracking demo and creates final app images for them on Debian
Bullseye using the buildpacks created in the delivery-pipeline folder.

This is effectively the same pipeline you'd create for any complex app
that needed a set of container images built when the apps themselves
are updated.

Note: We do not do standard CI steps (testing, scanning of libraries)
because that is best done on pull requests before the changes are
merged into the develop/main/release branches of an application's
Git repo.