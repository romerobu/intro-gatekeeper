#!/bin/sh

oc delete k8srequiredlabels.constraints.gatekeeper.sh/required-label-deployment
oc delete k8smaxrequests.constraints.gatekeeper.sh/pod-max-requests
oc delete k8smaxpods.constraints.gatekeeper.sh/deployment-max-pods
oc delete constraintTemplate k8smaxpods
oc delete constraintTemplate k8smaxrequests
oc delete constraintTemplate k8srequiredlabels
oc delete gatekeeper gatekeeper -n gatekeeper-system
oc delete subscription gatekeeper-operator-product -n openshift-operators
oc delete csv gatekeeper-operator-product.v0.1.2 -n openshift-operators
oc delete project gatekeeper-project gatekeeper-project-excluded gatekeeper-system
