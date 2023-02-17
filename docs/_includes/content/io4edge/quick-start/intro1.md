{% include content/io4edge/quick-start/prepare.md %}

## Prerequisites

### Hardware
{% if is_iou %}
* A Moducop Edge Computer with a {{ page.product_name }} installed
* A development PC (Windows or Linux), connected via Network to the Moducop{% else %}
* A target machine running Linux that is in the same network as your {{ page.product_name }}
* A development PC (Windows or Linux), connected via Network to the target machine{% endif %}
