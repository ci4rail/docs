
{% if is_iou %}

### Determine the Service Address of your {{ page.product_name }}
Io4Edge Devices are usually addressed by their service address, which is a name in the network.

The {{ page.product_name }}'s service name depends on the ModuCop's slot and is usually
`{{ full_product_name }}-USB-EXT-<slot-number>[-<function>]`, i.e. if the {{ page.product_name }} is in the slot next to ModuCops CPU01, we have the following service names:
{% endif %}

{% if is_mio %}

{% endif %}
