#!/bin/bash

export KUBE_NAMESPACE=${KUBE_NAMESPACE}
export KUBE_SERVER=${KUBE_SERVER}

if [[ -z ${VERSION} ]] ; then
    export VERSION=${IMAGE_VERSION}
fi


if [[ ${ENVIRONMENT} == "test" ]] ; then
    echo "deploy ${VERSION} to test namespace, using PTTG_FS_TEST drone secret"
    export KUBE_TOKEN=${PTTG_FS_TEST}
else
    echo "deploy ${VERSION} to dev namespace, using PTTG_FS_DEV drone secret"
    export KUBE_TOKEN=${PTTG_FS_DEV}
fi


if [[ -z ${KUBE_TOKEN} ]] ; then
    echo "Failed to find a value for KUBE_TOKEN - exiting"
    exit -1
fi


cd kd

kd --insecure-skip-tls-verify \
   -f networkPolicy.yaml \
   -f deployment.yaml \
   -f service.yaml \
   -timeout 10m