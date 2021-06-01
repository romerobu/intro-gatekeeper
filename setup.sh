#!/bin/sh


# Login

if ! oc whoami &> /dev/null; then
    echo -e "You must log in"
    exit 1
fi

# Create required projects

echo -n "Creating projects..."
oc new-project gatekeeper-system
oc new-project gatekeeper-project-excluded
oc new-project gatekeeper-project
oc new-project gatekeeper-resourcequota

# Set up gatekeeper operator

oc apply -f config/install-operator.yaml

echo -n "Waiting for pods ready..."
while [[ $(oc get pods  -n openshift-operators  -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo -n "." && sleep 1; done; echo -n -e "  [OK]\n"

sleep 5

# Create gatekeeper instance

echo -n "Creating gatekeeper..."
oc apply -f config/create-gatekeeper.yaml

echo -n "Waiting for pods ready..."
while [[ $(oc get pods  -n openshift-gatekeeper-system  -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True True True" ]]; do echo -n "." && sleep 1; done; echo -n -e "  [OK]\n"

sleep 5

# Deploy gatekeeper constraints and templates

echo -n "Deploying constraints..."
oc apply -f config/config.yaml

oc apply -f constraintTemplate/K8sMaxPods.yaml

oc apply -f constraintTemplate/K8sMaxRequests.yaml

oc apply -f constraintTemplate/K8sResourceQuota.yaml

sleep 10

oc apply -f constraints/K8sMaxPods.yaml
oc apply -f constraints/K8sMaxRequests.yaml
oc apply -f constraints/K8sResourceQuota.yaml


#oc apply -f constraintTemplate/K8sRequiredLabels.yaml
#oc apply -f constraintTemplate/NsRequiredLabel.yaml
#oc apply -f constraints/K8sRequiredLabels.yaml
#oc apply -f constraints/NsRequiredLabels.yaml
