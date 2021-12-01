#!/bin/sh

oc delete k8srequiredlabels.constraints.gatekeeper.sh/required-label-deployment
oc delete k8smaxrequests.constraints.gatekeeper.sh/pod-max-requests
oc delete k8smaxpods.constraints.gatekeeper.sh/deployment-max-pods
oc delete k8sresourcequota.constraints.gatekeeper.sh/resourcequota
oc delete constraintTemplate k8smaxpods
oc delete constraintTemplate k8smaxrequests
oc delete constraintTemplate k8srequiredlabels
oc delete constraintTemplate k8sresourcequota
oc delete gatekeeper gatekeeper -n gatekeeper-system
oc delete subscription gatekeeper-operator-product -n openshift-operators
oc delete csv gatekeeper-operator-product.v0.2.1 -n openshift-operators
oc delete clusterrole gatekeeper-ops-const-role
oc delete clusterrole gatekeeper-ops-role
oc delete clusterrole gatekeeper-opa-sec-ops
oc delete project gatekeeper-project gatekeeper-project-excluded gatekeeper-system gatekeeper-resourcequota
