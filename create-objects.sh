#!/bin/sh

oc apply -f examples/deployment-yes.yaml
oc apply -f examples/deployment-no-project.yaml
oc apply -f examples/deployment-no.yaml -n gatekeeper-system
oc apply -f examples/deployment-no.yaml -n gatekeeper-project-excluded
oc apply -f examples/pod-yes.yaml
oc apply -f examples/pod-no.yaml -n gatekeeper-project
oc apply -f examples/pod-no.yaml -n gatekeeper-project-excluded
oc apply -f examples/pod-no.yaml -n gatekeeper-system
oc apply -f examples/deployment-pod-no.yaml -n gatekeeper-project
