#!/bin/sh


# Login

# Check if the user is logged in
if ! oc whoami &> /dev/null; then
    echo -e "Check. You are not logged out. Please log in and run the script again."
    exit 1
else
    echo -e "Check. You are correctly logged in. Continue..."
fi

# Create required projects

echo -n "Creating projects..."
oc new-project prueba2
oc new-project gatekeeper-system
oc new-project prueba

# Set up gatekeeper operator

oc apply -f config/install-operator.yaml

echo -n "Waiting for pods ready..."
while [[ $(oc get pods -l name=gatekeeper-operator -n gatekeeper-system  -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo -n "." && sleep 1; done; echo -n -e "  [OK]\n"


# Create gatekeeper instance

echo -n "Creating gatekeeper..."
oc apply -f config/create-gatekeeper.yaml

# Deploy gatekeeper constraints and templates

echo -n "Deploying constraints..."
oc apply -f constraintTemplate/K8sMaxPods.yaml
oc apply -f constraintTemplate/K8sMaxRequests.yaml
oc apply -f constraintTemplate/K8sRequiredLabels.yaml
oc apply -f constraintTemplate/NsRequiredLabel.yaml

oc apply -f constraints/K8sMaxPods.yaml
oc apply -f constraints/K8sMaxRequests.yaml
oc apply -f constraints/K8sRequiredLabels.yaml
oc apply -f constraints/NsRequiredLabels.yaml
