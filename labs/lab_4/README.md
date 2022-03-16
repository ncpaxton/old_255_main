# Lab 4

The goal of `lab_4` is to extend your `FastAPI` application from `lab_3`. 

You will

- Use Kustomize to enable management between `Minikube` and `Azure Kubernetes Service (AKS)`
- Push your API image to `Azure Container Registry (ACR)` to enable deploying your application in a secure way to a production cluster
- Deploy your application to `AKS` using `istio` and `kustomize`
- In your local environment you will not use `istio`
  - This is why we use Kustomize

Additionally the following have been handled for you automatically:

- DNS (`{namespace}.mids-w255.com` using `external-dns`)
- TLS Cert (Let's encrypt certs generated using `cert-manager`)
- HTTP -> HTTPS redirection `istio-gateway`
- Istio Gateway for DNS `istio-gateway`

## Helpful Information

### Project Setup

Copy your code from lab 3 into a new lab folder `lab_4`. You will use the same model you trained in `lab_4`

- Install Azure CLI, `az` (<https://docs.microsoft.com/en-us/cli/azure/install-azure-cli>)
- Authenticate to Azure with your `@berkeley.edu` email
  - `az login --tenant berkeleydatasciw255.onmicrosoft.com`
- Set Subscription to the one for the class
  - `az account set --subscription="414b4da1-b6dd-480a-a797-cb14ea566766"`
- Authenticate to the `AKS` cluster
  - `az aks get-credentials --name w255-aks --resource-group w255 --overwrite-existing`
- Change your kubernetes context between the `AKS` cluster and `minikube`
  - `kubectl config use-context minikube`
  - `kubectl config use-context w255-aks`
- Login to `ACR` repository
  - `az acr login --name w255mids`
- Get your namespace prefix referred to as `$NAMESPACE` or `$IMAGE_PREFIX`
  - DNS Normalized form of your `@berkeley.edu` email address
  - DNS does not allow for _ or .
  - Change _ to - and remove all .
  - `winegarj@berkeley.edu` -> `winegarj`
  - `test_123.4@berkeley.edu` -> `test-1234`

### Links

- ACR
  - <https://portal.azure.com/#@berkeleydatasciw255.onmicrosoft.com/resource/subscriptions/414b4da1-b6dd-480a-a797-cb14ea566766/resourceGroups/w255/providers/Microsoft.ContainerRegistry/registries/w255mids/repository>
- AKS
  - Namespaces: <https://portal.azure.com/#@berkeleydatasciw255.onmicrosoft.com/resource/subscriptions/414b4da1-b6dd-480a-a797-cb14ea566766/resourceGroups/w255/providers/Microsoft.ContainerService/managedClusters/w255-aks/namespaces>
  - Workloads/Deployments: <https://portal.azure.com/#@berkeleydatasciw255.onmicrosoft.com/resource/subscriptions/414b4da1-b6dd-480a-a797-cb14ea566766/resourceGroups/w255/providers/Microsoft.ContainerService/managedClusters/w255-aks/workloads>
  - Services: <https://portal.azure.com/#@berkeleydatasciw255.onmicrosoft.com/resource/subscriptions/414b4da1-b6dd-480a-a797-cb14ea566766/resourceGroups/w255/providers/Microsoft.ContainerService/managedClusters/w255-aks/servicesAndIngresses>
- Azure DNS
  - <https://portal.azure.com/#@berkeleydatasciw255.onmicrosoft.com/resource/subscriptions/414b4da1-b6dd-480a-a797-cb14ea566766/resourceGroups/w255/providers/Microsoft.Network/dnszones/mids-w255.com/overview>

### Useful commands

Hitting `/predict` API endpoint

```{bash}
NAMESPACE=winegarj
curl -X 'GET' 'https://${NAMESPACE}.mids-w255.com/predict' -L -H 'Content-Type: application/json' -d '{"houses": [{ "MedInc": 8.3252, "HouseAge": 42, "AveRooms": 6.98, "AveBedrms": 1.02, "Population": 322, "AveOccup": 2.55, "Latitude": 37.88, "Longitude": -122.23 }]}'
```

Using non-`latest` tags for production deployment

```{bash}
TAG=$(some way to generate random strings)
sed "s/\[TAG\]/${TAG}/g" .k8s/overlays/prod/patch-deployment-lab4_copy.yaml > .k8s/overlays/prod/patch-deployment-lab4.yaml
```

Generate and apply kustomize files

```{bash}
kubectl kustomize .k8s/overlays/dev
kubectl apply -k .k8s/overlays/dev
```

Various `Istio`/`Cert-Manager`/`External-DNS` lookups

```{bash}
kubectl --namespace externaldns logs -l "app.kubernetes.io/name=external-dns,app.kubernetes.io/instance=external-dns"
kubectl --namespace istio-ingress get certificates ${NAMESPACE}-cert
kubectl --namespace istio-ingress get certificaterequests
kubectl --namespace istio-ingress get gateways ${NAMESPACE}-gateway 
```

## Requirements

1. Create a `.k8s` directory in your `lab_4` folder
   - Create subdirectories for `bases`, `dev`, `prod`
   - Copy the available stubs in this directory
   - Modify to work within your namespace
2. Push your image to a namespaced location in ACR
   - Example: `w255mids.azurecr.io/winegarj/lab4:latest`
3. Modify the stubs to allow for local development
4. Review the stubs for production and make any changes required
   - A `VirtualService` will be required for `AKS`
5. Deploy your application in `AKS`
6. Be able to get a prediction from your API in `AKS`
   - You will automatically be able to access your API at `$NAMESPACE.mids-w255.com/{predict,health}` if you configured everything appropriatly.
7. An example `curl` request we can use to test against `$NAMESPACE.mids-w255.com/predict` that meets your request model in your API.

```{bash}
# Image prefix is a DNS-compliant version of your berkeley email address
# DNS does not allow for _ or .
# Change _ to - and remove all . if you want to manually write IMAGE_PREFIX
# Example: winegarj@berkeley.edu -> winegarj
# Example: test_123.4@berkeley.edu -> test-1234
# IMAGE_PREFIX=winegarj
IMAGE_PREFIX=$(az account list --all | jq '.[].user.name' | grep -i berkeley.edu | awk -F@ '{print $1}' | tr -d '"' | uniq)

# FQDN = Fully-Qualiifed Domain Name
IMAGE_NAME=lab4
ACR_DOMAIN=w255mids.azurecr.io
IMAGE_FQDN="${ACR_DOMAIN}/${IMAGE_PREFIX}/${IMAGE_NAME}"

az acr login --name w255mids

docker tag ${IMAGE_NAME} ${IMAGE_FQDN}
docker push ${IMAGE_FQDN}
docker pull ${IMAGE_FQDN}
```

## Additional Requirements

1. All requirements of Lab 3

## Expected Final Folder Structure

```{text}
.
└── .gitignore
├── lab_1
├── lab_2
├── lab_3
├── lab_4
|   ├── lab4
│   │   ├── .k8s
│   │   │   ├── bases
│   │   │   │   ├── config-map.yaml
│   │   │   │   ├── deployment-lab4.yaml
│   │   │   │   ├── deployment-redis.yaml
│   │   │   │   ├── kustomization.yaml
│   │   │   │   ├── persistent-volume.yaml
│   │   │   │   ├── service-lab4.yaml
│   │   │   │   └── service-redis.yaml
│   │   │   └── overlays
│   │   │       ├── dev
│   │   │       │   ├── kustomization.yaml
│   │   │       │   └── patch-lab4.yaml
│   │   │       └── prod
│   │   │           ├── kustomization.yaml
│   │   │           ├── patch-deployment-lab4.yaml
│   │   │           ├── patch-deployment-lab4_copy.yaml
│   │   │           └── virtual-service.yaml
|   │   ├── Dockerfile
|   │   ├── README.md
|   │   ├── lab4
|   │   │   ├── __init__.py
|   │   │   └── main.py
|   │   ├── model_pipeline.pkl
|   │   ├── poetry.lock
|   │   ├── pyproject.toml
|   │   └── tests
|   │       ├── __init__.py
|   │       └── test_hello.py
|   │       └── test_predict.py
|   └── run.sh
├── lab_5
└── project
```

## Submission

All code will be graded off your repo's `main` branch. No additional forms or submission processes are needed.

## Grading

Grades will be given based on the following:

1. Adhesion to requirements
2. Ability to build, deploy to k8s, and run application using `run.sh`
3. Ability to test the code with `poetry run pytest`

### Rubric

- ACR Image: 2 points
- Kustomize configuration: 2 points
- Correct ACR image location and Istio Gateway references: 3 points
- Succcessful Istio Virtual Service Routes to API (with `curl` reference): 3 points

## Additional Considerations (Not Required)

- Liveness Probe
- Readiness Probe
- Init Containers
- How `external-dns`, `cert-manager`, and `istio` are configured
- Helm for deployments with less repeated elements
- Redis
  - StatefulSets
  - PersistentVolumes

## Time Expectations

This lab will take approximately ~10-20 hours. Most of the time will be spent configuring kustomize and reviewing the istio processes.
