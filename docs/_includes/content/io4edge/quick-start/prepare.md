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
