#!/bin/bash

NAMESPACE="smart-home"

kubectl apply -f smart-home-ns-admin-rolebinding.yaml
kubectl apply -f smart-home-ns-developer-rolebinding.yaml

echo "RoleBindings smart-home-ns-admin-binding и smart-home-ns-developer-binding созданы и применены в namespace ${NAMESPACE}"