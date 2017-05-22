#!/bin/sh

# creating new project
oc new-project enmasse --description="Messaging as a Service" --display-name="EnMasse"

oc create sa enmasse-service-account -n $(oc project -q)
oc policy add-role-to-user view system:serviceaccount:$(oc project -q):default
oc policy add-role-to-user edit system:serviceaccount:$(oc project -q):enmasse-service-account
oc process -f https://github.com/EnMasseProject/enmasse/releases/download/0.10.0/enmasse-template.yaml | oc create -f -
