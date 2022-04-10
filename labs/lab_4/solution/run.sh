#!/bin/bash
IMAGE_NAME=lab4
APP_NAME=${IMAGE_NAME}
NAMESPACE=winegarj
DOMAIN=mids-w255.com
ACR_DOMAIN=w255mids.azurecr.io
IMAGE_FQDN="${ACR_DOMAIN}/${NAMESPACE}/${IMAGE_NAME}"
AZ_AKS_NAME="w255-aks"
AZ_RESOURCE_GROUP="w255"

# set context
az aks get-credentials --name ${AZ_AKS_NAME} --resource-group ${AZ_RESOURCE_GROUP} --overwrite-existing --admin
az acr login --name w255mids

# rebuild new image
cd ${APP_NAME}
docker build -t ${IMAGE_NAME} .

# create a random tag, usually this would be a git commit sha
TAG=$(openssl rand -hex 4)
docker tag ${IMAGE_NAME} ${IMAGE_FQDN}:${TAG}
docker push ${IMAGE_FQDN}:${TAG}
# Force the tag into the prod deployment
sed "s/\[TAG\]/${TAG}/g" .k8s/overlays/prod/patch-deployment-lab4_copy.yaml > .k8s/overlays/prod/patch-deployment-lab4.yaml

# deploy
kubectl apply -k .k8s/overlays/prod

# wait for the /health endpoint to return a 200 and then move on
finished=false
while ! $finished; do
    health_status=$(curl -o /dev/null -s -w "%{http_code}\n" -X GET "http://${NAMESPACE}.${DOMAIN}/health" -L)
    if [ $health_status == "200" ]; then
        finished=true
        echo "API is ready"
    else
        echo "API not responding yet"
        sleep 5
    fi
done

# output and tail the logs for the api deployment
kubectl logs -n ${NAMESPACE} -l app=${APP_NAME}