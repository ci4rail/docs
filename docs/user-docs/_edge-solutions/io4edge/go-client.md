---
title: io4edge Go Client Library
excerpt: How to install and use the io4edge Go Client Library
---

## Installation

Either
```bash
go get github.com/moducop/io4edge-client-go
```

or put the following in your `go.mod` file:
```go
require github.com/moducop/io4edge-client-go vx.y.z
```
## Usage

In your code, import the library:
```go
import "github.com/moducop/io4edge-client-go"
```

## Usage from containers

To access io4edge devices via mdns service name, mount dbus and avahi daemon socket into container:

For example:
```bash
docker run -v /var/run/dbus:/var/run/dbus -v /var/run/avahi-daemon/socket:/var/run/avahi-daemon/socket <your image>
```
