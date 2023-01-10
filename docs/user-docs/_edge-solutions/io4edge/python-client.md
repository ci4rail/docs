---
title: io4edge Python Client Library
excerpt: How to install and use the io4edge Python Client Library
---

## Installation

```bash
pip3 install io4edge-client
```

## Usage

In your code, import the necessary modules from the library, for example:
```python
import io4edge_client.binaryiotypec as binio
import io4edge_client.functionblock as fb
```

## Usage from containers

To access io4edge devices via mdns service name, run the container in host network mode.

For example:
```bash
docker run --network=host <your image>
```

## Using io4edge Python Client Library on ModuCop

When using Ci4Rail Yocto images, such as the images for ModuCop, you can't install the io4edge-client python library directly into the root file system, as it is write-protected. Build a docker container with your application and the io4edge-client library and then run this container on ModuCop.

For development purposes, you can use vscode remote ssh and vscode devcontainer. Detailed instructions are available on request.
