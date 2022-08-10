{% if is_iou %}
If you are unsure, you can also browse the available devices:
```bash
ssh root@<moducop-ip>
```

Once logged in into the Moducop Shell:
```bash
avahi-browse -at | grep io4edge
```
{% endif %}
{% if is_mio %}
{% endif %}
