#!/bin/bash

CONTEXT=$1

if [[ "$CONTEXT" == "" ]]; then
    echo "missing context"
    exit 1
fi

OPTIONS=" --namespace=helloapi --context=${CONTEXT}"
kubectl delete $OPTIONS cm config-map-helloapi
kubectl delete $OPTIONS ingress helloapi-domain
kubectl delete $OPTIONS svc helloapi-svc
kubectl delete $OPTIONS deploy helloapi-deploy
kubectl --context=${CONTEXT} delete namespaces helloapi

exit 0
