
We need this service address in the demo programs to address the module, for example to address the binary I/O function, we would use `{{ full_product_name }}-USB-EXT-1-binaryIoTypeA `.

{% if is_iou %}
If you are unsure, you can also browse the available devices:
```bash
ssh root@<moducop-ip>
```

Once logged in into the Moducop Shell:
```bash
avahi-browse -at | grep io4edge
```
If your {{ page.product_name }} is in the slot next to the CPU, the output should be:
```
+ usb_ext_1 IPv4 {{ mdns_service_address }}                          _io4edge-core._tcp   local
+ usb_ext_1 IPv4 {{ mdns_service_address }}-binaryIoTypeA            _io4edge_binaryIoTypeA._tcp local
+ usb_ext_1 IPv4 {{ mdns_service_address }}-analogInTypeA2           _io4edge_analogInTypeA._tcp local
+ usb_ext_1 IPv4 {{ mdns_service_address }}-analogInTypeA1           _io4edge_analogInTypeA._tcp local
```
{% endif %}
