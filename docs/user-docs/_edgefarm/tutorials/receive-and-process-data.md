---
title: Receive and Process MQTT Data
excerpt: Simple example of receiving MQTT data from an external device and transferring the data to the cloud using the `train simulator`
last_modified_at: 2021-07-30
type: train simulator
---
In this tutorial, you will learn how to receive and process data from MQTT data sources. This tutorial uses the ``train simulator`` to create the external data. In order to process those external data in your edge device, an application on the edge device is required. You are going to deploy a demo application on the edge device to read the data received from the `train simulator` and handle them. The demo application subscribes to the respective topic using the EdgeFarm Service Module `mqtt-bridge` and sends the data unmodified into the cloud. The data can be viewed in the cloud on a Grafana Dashboard.

![Architecture]({{ 'user-docs/images/edgefarm/tutorials/hvac-arch.svg' | relative_url }} "Architecture"){: style="width: 50%"}

# Pre-Conditions
To successfully walk through the next steps, please make sure, that the following actions have been performed.

* `train simulator` up and running. See the tutorial [Setting up a External Simulation Environment]({{ '/edgefarm/tutorials/setup-simulator/' | relative_url }}) for assistance.
* `EdgeFarm-cli` installed. See [install instructions]({{ '/edgefarm/reference-manual/prerequisites/edgefarm-cli/' | relative_url }}) for assistance.
* Cloned `train-simulator` repository. This is done in [Setting up a External Simulation Environment]({{ '/edgefarm/tutorials/setup-simulator/#get-the-train-simulator-up-and-running' | relative_url }}).
* Base deployment for `train-simulator` tutorials is applied. This is explained in tutorial [Apply Simulator Base Deployment]({{ '/edgefarm/tutorials/simulator-base-deployment/' | relative_url }}).

# View the simulated data in `train simulator` Dashboard

The simulated data is visually displayed in the Node-Red Dashboard. It can be viewed by visiting [http://localhost:1880/ui](http://localhost:1880/ui). This tutorial is located in the `Climate Conditions` section of the `train-simulaton`.

![Climate Conditions Dashboard]({{ 'user-docs/images/edgefarm/tutorials/climate-conditions-dashboard.png' | relative_url }} "Climate Conditions Dashboard"){: style="width: 75%"}

# Deploy the Application Manifest

Find the deployment manifest `hvac.yaml` in `train-simulator` repository in directory `usecase-1` and apply the application manifest by the corresponding EdgeFarm CLI command:
```console
$ cd usecase-1/
$ edgefarm applications apply -f hvac.yaml
Successfully deployed: hvac
```

Now wait for the module to get deployed. The deployment status can be checked using EdgeFarm CLI:
```console
$ edgefarm applications get deployments -o w -m

Tenant:         demo
Application:    basis
Creation date:  2021-07-30 10:21:16
+-------+---------------------------+-----------------+------------------+------------------+---------+
| TYPE  |          MODULES          | LABEL SELECTORS |     TARGETED     |     SUCCESS      | FAILURE |
+-------+---------------------------+-----------------+------------------+------------------+---------+
| all   | ads-node-module           |                 | demo_cloud       | demo_cloud       |         |
|       |                           |                 | moducop-gecko    | moducop-gecko    |         |
| edge  | mqtt-bridge               |                 | moducop-gecko    | moducop-gecko    |         |
+-------+---------------------------+-----------------+------------------+------------------+---------+

Tenant:         demo
Application:    hvac
Creation date:  2021-07-30 11:57:20
+-------+---------------------------+-----------------+------------------+------------------+---------+
| TYPE  |          MODULES          | LABEL SELECTORS |     TARGETED     |     SUCCESS      | FAILURE |
+-------+---------------------------+-----------------+------------------+------------------+---------+
| edge  | push-temperature          |                 | moducop-gecko    | moducop-gecko    |         |
+-------+---------------------------+-----------------+------------------+------------------+---------+
```

# View the `train simulator` data in Grafana Dashboard

To access Grafana instance, your tenant ID is required. This can be figured out with the follwoing command:
```console
$ edgefarm applications get deployments
+--------+-------------+---------------------+
| TENANT | APPLICATION |    CREATION DATE    |
+--------+-------------+---------------------+
| demo   | basis       | 2021-07-30 10:21:16 |
| demo   | hvac        | 2021-07-30 11:57:20 |
+--------+-------------+---------------------+
```

The most left column contains the tenant ID, in this case it is `demo`. The URL for your grafana instance is made up of your tenant ID and the EdgeFarm Grafana basis URL as follows:
```
https://<tenant ID>.grafana.edgefarm.io
```

So, in this case, we need to open `https://demo.grafana.edgefarm.io` in the web browser.

![Login Grafana]({{ 'user-docs/images/edgefarm/tutorials/login-grafana.png' | relative_url }} "Login Grafana"){: style="width: 30%"}

Clicking on `Sign in with Auth0` will redirect you to Auth0 login.

![Login Auth0]({{ 'user-docs/images/edgefarm/tutorials/login-auth0.png' | relative_url }} "Login Auth0"){: style="width: 25%"}

Enter your EdgeFarm credentials here and confirm with `Continue`. You should now have successfully logged into your private grafana area.

View the prepared dashboards by going to dashboards and click on `Manage.`

![Go to Dashboards]({{ 'user-docs/images/edgefarm/tutorials/go-to-dashboards.png' | relative_url }} "Go to Dashboards"){: style="width: 70%"}

The folder `demo` contains all Dashboards prepared for demonstration purposes. For this scenario, the required Dashboard is ``


# Achievements of this Section
Congratulations! You just finished deployed an application, which receives data via MQTT from `train simulator` and transmits it to EdgeFarm.data service.
You also learned about how to view the `train simulator` data in the simulator's Dashboard and the EdgeFarm Grafana Dashboard.
