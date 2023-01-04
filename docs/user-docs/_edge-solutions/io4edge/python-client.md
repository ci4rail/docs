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
