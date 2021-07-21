---
title: Quick-Start-Guide
excerpt: First steps with EdgeFarm basic functions.
last_modified_at: 2021-07-21
---

This chapter shows the basic usage of the EdgeFarm CLI to interact with the EdgeFarm services.

{% include_relative reference-manual/prerequisites/_edgefarm-cli.md %}

# Basic Features of `EdgeFarm-cli`

## Login

To make use of any EdgeFarm services, you first have to sign on using the `login` subcommand. Your user and password will be handed over in a personal conversation.

```console
$ edgefarm login
✔ Username: user@tenant1.com
Password:
Login Succeeded
Logged in as: Stan Marsh
```

## List Edge Devices

List the devices registered in EdgeFarm DLM for your account by using the `dlm get devices` subcommand.

```console
$ edgefarm dlm get devices
DEVICE ID                               	CONNECTION STATE
moducop0                                	Connected
```

## List runtimes

List the runtimes registered in EdgeFarm ALM for your account using the `alm get runtimes` subcommand.

```console
$ edgefarm alm get runtimes
RUNTIME ID                               	CONNECTION STATE
moducop0                                	Connected
```

## Applying manifest

In order to deploy a specific configuration of applications to the edge computer, we are going to use so-called application manifest files. To apply such an application manifest file use the `alm apply` subcommand.

As a first example, the following section explains how create and apply your first manifest file. In this case we will deploy a nginx web server to the edge device.

```yaml
---
application: webserver
modules:
  - name: nginx
    image: nginx:1.19.5
    createOptions: '{\"HostConfig\":{\"PortBindings\":{\"80/tcp\":[{\"HostPort\":\"8080\"}]}}}'
    imagePullPolicy: on-create
    restartPolicy: always
    status: running
    startupOrder: 1
```

Copy the above example in a yaml file, e.g. `manifest.yaml`. Then apply it.

```console
$ edgefarm alm apply -f manifest.yaml
```

To see the result of your frst application deployment by using application manifest files, you need to login to the edge device. See [Connecting to ModuCop’s Linux Terminal](/quick-start-guide/moducop/connect-to-terminal/) for assistance.
Now wait for the containers get deployed.

You can monitor the status of the deployment by triggering `docker ps` manually and looking for a container called `webserver_nginx`
Once the deployment is done the output should look similar to this.

```console
$ docker ps
CONTAINER ID  IMAGE         COMMAND                 CREATED        STATUS                 PORTS                 NAMES
463d7e32c250  nginx:1.19.5  "/docker-entrypoint.…"  9 seconds ago  Up Less than a second  0.0.0.0:8080->80/tcp  webserver_nginx
```

In the next step, you download and test the webserver locally on the edge device.
```console
$ cd /data
$ wget localhost:8080
Connecting to localhost:8080 (127.0.0.1:8080)
saving to 'index.html'
index.html           100% |**********************************************************************************************************************************************|   612  0:00:00 ETA
'index.html' saved

$ cat index.html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

You also can open a new browser tab with this URI `http://<IP>:8080` where you put in the IP address of your edge device. You should see a welcome message from the nginx webserver.

# Achievements in this Section
Well done, you have successfully logged on to the EdgeFarm services, got familier with the basic functionalities like listing all your connected devces and you deployed your first application to an edge computer.

Cool, isn't it? Go on, we have more for you to test!
