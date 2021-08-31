---
title: Data Endpoint Access
excerpt: How to Access EdgeFarm Data Endpoint
last_modified_at: 2021-08-31
---

EdgeFarm.data provides an data export using `NATS Jetstream`. The data within this endpoint is puffered for at least `48 hours`, `100000 messages` or `2 GB`. Messages reaching the limits are dropped and cannot be restored.

**Pre-Condition**
* NAT's credentials `natsEndpoint.creds` (provided from Ci4Rail)
* NATS CLI installed (See [Installation](https://github.com/nats-io/natscli#installation))

# View Data Endpoint Information

Information about the data endpoint can be viewed using the following command:
```console
$ nats stream report \
        -s tls://connect.ngs.global:4222 \
        --creds=natsEndpoint.creds
Obtaining Stream stats

╭─────────────────────────────────────────────────────────────────────────────────────────╮
│                                      Stream Report                                      │
├────────┬─────────┬───────────┬──────────┬─────────┬──────┬─────────┬────────────────────┤
│ Stream │ Storage │ Consumers │ Messages │ Bytes   │ Lost │ Deleted │ Replicas           │
├────────┼─────────┼───────────┼──────────┼─────────┼──────┼─────────┼────────────────────┤
│ EXPORT │ File    │ 1         │ 14,145   │ 793 KiB │ 0    │ 0       │ ci4rail_ngs0001-3* │
╰────────┴─────────┴───────────┴──────────┴─────────┴──────┴─────────┴────────────────────╯
```

This shows how many messages are stored in the endpoint (`Messages`) and how much memory they require (`Bytes`).

# Get Data From Endpoint

Data can be received using the following command:

```console
$ nats consumer next EXPORT CUSTOMER \
        -s tls://connect.ngs.global:4222 \
        --creds=natsEndpoint.creds \
        -r
{"app":"hvac","module":"hvac_push-temperature","payload":{"temp":31.33},"time":"\"2021-08-31T06:20:12Z\""}
```

The output received is the transmitted data including EdgeFarm.data metadata in json format.
