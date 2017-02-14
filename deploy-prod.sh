#!/usr/bin/env bash
export KUBE_NAMESPACE=${KUBE_NAMESPACE}
export ENVIRONMENT=${ENVIRONMENT}
export APP=pttg-fs-stub
export KUBE_SERVER=${KUBE_SERVER_PROD}
export KUBE_TOKEN=${KUBE_TOKEN_PROD}

echo ${KUBE_SERVER_DEV}

if [ -z ${KUBE_TOKEN_PROD+x} ]
then
    echo "KUBE_TOKEN_PROD must be set"
else
    echo "KUBE_TOKEN_PROD is set"
fi

cd kd
kd --debug \
   --insecure-skip-tls-verify --timeout 5m0s \
   --file ${ENVIRONMENT}/pttg-fs-stub-deployment.yaml \
   --file ${ENVIRONMENT}/pttg-fs-stub-svc.yaml