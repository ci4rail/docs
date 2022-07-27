### Initial Device Configuration

For initial configuration, connect the `SERVICE` interface to a computer and start a terminal program. See [Instructions]({{ '/edge-solutions/modusio/config-console' | relative_url }}) for details.

Press Enter in the Terminal program, and you should see the config prompt:

```
config>
```

#### Configure Device ID
To identify the device in the network, configure a device ID. This ID is used as the network hostname and as a prefix to identify the services provided by the device.
```
config> device-id {{ page.product_name }}-1
Setting device-id to '{{ page.product_name }}-1'
A 'reboot' is required to activate the new setting!
```
