{% assign full_product_name = page.article_group | append: "-" | append: page.product_name %}
{% if page.article_group == "S103" %}
  {% assign is_mio = true %}
  {% assign example_exec_dir = "." %}
  {% assign target_name ="target machine" %}
{% else %}
  {% assign is_iou = true %}
  {% assign example_exec_dir = "/data" %}
  {% assign target_name ="Moducop" %}
{% endif %}

## Prerequisites

### Hardware
{% if is_iou %}
* A Moducop Edge Computer with a {{ page.product_name }} installed
* A development PC (Windows or Linux), connected via Network to the Moducop{% else %}
* A target machine running Linux that is in the same network as your {{ page.product_name }}
* A development PC (Windows or Linux), connected via Network to the target machine{% endif %}
