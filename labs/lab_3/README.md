# Lab 3

The goal of `lab_3` is to extend your `FastAPI` application from `lab_2`. 

You will make your API take a list of inputs to predict instead of a single input. You will add a naive Redis cache to your API for the `/predict` endpoint based on the inputs. You will ensure GitHub actions works for new pull requests. And you will deploy locally on a Kubernetes environment.

## Helpful Information

### Project Setup

Copy your code from lab 2 into a new lab folder `lab_3`. You will use the same model you trained in `lab_3`

Install `minikube` ([Docs](https://minikube.sigs.k8s.io/docs/start/))

Change Kubernetes version to match what we will deploy into Azure Kubernetes Service (AKS) for the project, `1.21.7`. We will only use AKS for the project.

`minikube start --kubernetes-version=v1.21.7`

## Requirements

Build a `FastAPI` with the following:

1. All requirements from `lab_2`
2. `README.md` for how to build, run, and test code in app root directory (minimal, a few lines is plenty)
3. Ensure `/predict` takes a `List` of inputs based on a `pydantic` model instead of only a single record
4. For the entire input `List` to `/predict` cache the record in Redis.
   - This is a naive approach to caching to protect you from repeated messages
5. Deploy your application to Kubernetes
   1. Use a non-default `namespace` called `w255`
   2. Deployment for Redis in `w255` namespace
   3. Deployment for API in `w255` namespace
   4. Service for Redis in `w255` namespace
   5. Service for API in `w255` namespace

Remember that we're using a REST API framework. So we expect the framework to handle some of our concerns. As you review the Objectives and Requirements keep this in mind. Try to keep everything as simple as possible while achieving the goals.

## Additional Requirements

1. All requirements of Lab 2
2. `run.sh`

## Expected Final Folder Structure

```{text}
.
└── .gitignore
├── lab_1
├── lab_2
├── lab_3
|   ├── lab3
|   |   ├── infra
|   |   |   ├── deployment.yaml
|   |   |   ├── namespace.yaml 
|   |   |   └── service.yaml
|   │   ├── Dockerfile
|   │   ├── README.md
|   │   ├── lab3
|   │   │   ├── __init__.py
|   │   │   └── main.py
|   │   ├── model_pipeline.pkl
|   │   ├── poetry.lock
|   │   ├── pyproject.toml
|   │   └── tests
|   │       ├── __init__.py
|   │       └── test_lab2.py
|   └── run.sh
├── lab_4
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

- Functional API: 2 points
- Caching: 3 points
- Kubernetes Deployment: 5 points

## Time Expectations

This lab will take approximately ~20 hours. Most of the time will be spent configuring Kubernetes, the deployment, and services, followed by testing to ensure everything is working correctly. Minimal changes to the API are required.
