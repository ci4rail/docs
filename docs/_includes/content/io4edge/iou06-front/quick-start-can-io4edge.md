# CAN Demo using Io4Edge API

In this demo, we'll demonstrate how to receive data from a CAN bus and print it to the console. This demo directly accesses the {{ page.product_name }} CAN interface via the Io4Edge API.

**Warning** On the the {{ page.product_name }}, the CAN and COM ports **cannot be used at the same time**. To enable CAN, set a *persistent* [bus configuration]({{ '#busconfiguration' }}). If you want to use the COM ports, remove the persistent bus configuration.
{: .notice--warning}


{% include content/io4edge/quick-start/intro1.md %}
* CANbus with at least one CAN device
* Cable to connect the CAN device with the {{ page.product_name }}

{% include content/io4edge/quick-start/tools.md %}
{% include content/io4edge/quick-start/get-software.md %}


{% assign example_name="streamDump" %}
{% assign example_path="canL2" %}
{% assign example_service_name = page.example_device_name | append: "-can" %}

{% include content/io4edge/iou06-front/can-config-connect.md %}

### Demo Software
{% include content/io4edge/io4edge-go-example.md %}

```bash
{{ example_exec_dir }}/{{example_name}} {{ example_service_name }}
```

Now you should see all frames that are sent on the CAN bus. Example:

```
Started stream
got stream data with 3 samples
  @56036918665 us: ID:7ff DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
  @56037270984 us: ID:123 DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
  @56037462740 us: ID:456 DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
got stream data with 3 samples
  @56038232385 us: ID:222 DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
  @56038422757 us: ID:334 DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
  @56038632969 us: ID:555 DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
...
```
