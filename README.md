# DevDay "Messaging as a Service" demo

## Prerequisites

For this demo, you need the OpenShift client tools and for that you can download the [OpenShift Origin](https://github.com/openshift/origin/releases) ones.
Follow [this guide](https://github.com/openshift/origin/blob/master/docs/cluster_up_down.md) for setting up a local developer instance of OpenShift, for having an accessible registry for Docker and starting the cluster locally.

## Deployment

After having the OpenShift cluster up and running, the EnMasse instance can be deployed just using the following script from the "scripts" folder.

        bash enmasse_deploy.sh

Finally, in order to avoid creating addresses using the console UI, you can use the following script which deploys addresses from the _addresses.json_ file in the "scripts" directory.

        bash addresses_deploy.sh

## Example Docker image

All the Python examples are provided through a Docker image. Building the image (using the provided Dockerfile) allows you to have a working environment (with the Qpid Proton project installed) with all Python example running.

After building the Docker image (i.e. with name ppatierno/devday:latest), a container can be launched in the following way :

        docker run -it --net=host --name proton_devday ppatierno/devday:latest /bin/bash

The _--net=host_ option is used in order to connect to the host network reaching the OpenShift cluster deployed on that.
In order to run another console using the same container (i.e. for running clients, server, ....), you can use :

        docker exec -it proton_devday /bin/bash

## Python examples

The demo provides the following Python examples (hacking the original ones from the Qpid Proton project) :

* simple_send.py : it's just the original Qpid Proton simple_send.py
* forever_recv.py : it's a receiver which connects to an address waiting forever incoming messages
* server.py : it's a server which connects to the router network (messaging service in EnMasse) listening for requests (incoming messages) and replying with the upper cased body
* client.py : it's a client which connects to the router network (messaging service in EnMasse) sending some messages to the above server and waiting for the response

Examples :

A sender which sends 10 messages to queue "myqueue" (deployed on a broker) and the related receiver that is listening on that.

        simple_send.py -a amqp://172.30.90.124:5672/myqueue -m 10

        forever_recv.py -a amqp://172.30.90.124:5672/myqueue

A sender which sends 10 messages to address "anycast" (direct messaging) and the related receiver that is listening on that.

        simple_send.py -a amqp://172.30.90.124:5672/anycast -m 10

        forever_recv.py -a amqp://172.30.90.124:5672/anycast

A server listening for requests on the "request" address (direct messaging) and the related client sending requests on that. The client will specify a "dynamic" link for receiving the responses.

        server.py -a amqp://172.30.90.124:55673/request

        client.py -a amqp://172.30.90.124:5672/request

A server listening for requests on the "myqueue" address (a queue deployed on a broker) and the related client sending requests on that. The client will specify a "dynamic" link for receiving the responses.

        server.py -a amqp://172.30.90.124:55673/myqueue

        client.py -a amqp://172.30.90.124:5672/myqueue
