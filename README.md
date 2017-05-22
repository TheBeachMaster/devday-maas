# devday-maas
DevDay "Messaging as a Service" demo

## Prerequisites

For this demo, you need the OpenShift client tools and for that you can download the [OpenShift Origin](https://github.com/openshift/origin/releases) ones.
Follow [this guide](https://github.com/openshift/origin/blob/master/docs/cluster_up_down.md) for setting up a local developer instance of OpenShift, for having an accessible registry for Docker and starting the cluster locally.

## Deployment

After having the OpenShift cluster up and running, the EnMasse instance can be deployed just using the following script from the "scripts" folder.

        bash enmasse_deploy.sh

Finally, in order to avoid creating addresses using the console UI, you can use the following script which deploys addresses from the _addresses.json_ file in the "scripts" directory.

        bash addresses_deploy.sh
