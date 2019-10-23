#!/bin/bash

CONTEXT=$1

if [[ "$CONTEXT" == "" ]]; then
    echo "missing context"
    exit 1
fi

OPTIONS=" --namespace=helloapi --context=${CONTEXT}"

kubectl --context=${CONTEXT} apply -f "./namespace.json"
kubectl $OPTIONS apply -f "./${CONTEXT}/config-map-helloapi.yaml"
kubectl $OPTIONS apply -f "./${CONTEXT}/helloapi-deploy.yaml"
kubectl $OPTIONS apply -f "./${CONTEXT}/helloapi-svc.yaml"
kubectl $OPTIONS apply -f "./${CONTEXT}/helloapi-ingress-domain.yaml"

exit 0
