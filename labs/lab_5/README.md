# Lab 5

The goal of `lab_5` is to performance test your application which has been deployed on `Azure Kubernetes Service (AKS)`.

- Use `K6` to load test your `/predict` endpoint
- Use the `Prometheus` Time Series Database (TSDB) to capture metrics from `istio` proxy sidecars
- Use `Grafana` to visualize these metrics using `istio`'s prebuilt dashboards

Additionally the following have been handled for you automatically:

- Metrics capture for `istio` proxy sidecars using a `Prometheus` `ServiceMonitor`
- `Grafana` Dashboards built by the `istio` team for visualization of data captured by various `ServiceMonitors` for `workloads` (`Deployments`/`StatefulSets`) and `services`.
- `Kiali` for visualization of network traffic within the cluster.
- DNS (`{namespace}.mids-w255.com` using `external-dns`)
- TLS Cert (Let's encrypt certs generated using `cert-manager`)
- HTTP -> HTTPS redirection `istio-gateway`
- Istio Gateway for DNS `istio-gateway`

## Helpful Information

### Project Setup

Your application should already be deployed to `AKS` from `lab4` if it is not then redeploy `lab4`.

Install `K6`: <https://k6.io/docs/getting-started/installation/>

### Links

- `K6`
  - <https://k6.io/docs/getting-started/running-k6/>

### Useful commands

`k6 run load.js`

`kubectl port-forward -n prometheus svc/grafana 3000:3000`

## Requirements

1. Run k6 against your endpoint with the `load.js`
   1. Modify your API or the `load.js` file to support your endpoint's schema
   2. Current structure of the test is as below

```{json}
{
        "houses": [
            {
                "MedInc": 1,
                "HouseAge": 2,
                "AveRooms": "3",
                "AveBedrms": 4,
                "Population": 5,
                "AveOccup": 6,
                "Latitude": 7,
                "Longitude": 8,
            }
        ]
    }
```

2. Screenshots of `grafana` dashboard for your service/workload during execution of the `k6` script
   - You will need to port-forward `grafana` to your `localhost` to get access
   - `kubectl port-forward -n prometheus svc/grafana 3000:3000`
3. Change the `CACHE_RATE` between `0` and `1` and observe the stability of your endpoint
4. Document your findings/results in a `README.md` file and include images from `grafana` supporting your findings
5. Images should be presented in `GitHub` when navigating to the `lab_5` folder in your repository

## Additional Requirements

1. All requirements of Lab 4

## Expected Final Folder Structure

```{text}
.
└── .gitignore
├── lab_1
├── lab_2
├── lab_3
├── lab_4
└── lab_5
    ├── README.md
    ├── image1.png
    ├── image2.png
    ├── image3.png
    ├── image4.png
    └── load.js
└── project
```

## Submission

All code will be graded off your repo's `main` branch. No additional forms or submission processes are needed.

## Grading

Grades will be given based on the following:

1. Adhesion to requirements

### Rubric

- Narrative about performance when changing `CACHE_RATE`: 5 points
- Images embedded in `README.md`: 4 points
- Included and/or updated K6 script to hit your `/predict` endpoint: 1 point

## Time Expectations

This lab will take approximately ~4-6 hours. Most of the time will be spent running your `k6` script and reviewing
`grafana` dashboards.
