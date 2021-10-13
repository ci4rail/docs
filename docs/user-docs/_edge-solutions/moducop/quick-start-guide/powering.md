---
title: Connecting & Powering
excerpt: How to power the ModuCop.
last_modified_at: 2021-10-13

custom_previous: /edge-solutions/moducop/quick-start-guide/unpacking/
custom_next: /edge-solutions/moducop/quick-start-guide/interfaces/
---

In this section you will connect your ModuCop to the power supply and all relevant interface connections asuming you use the ACS01 Starter kit. Otherwise you will need the accessories described [here]({{ '/edge-solutions/moducop/quick-start-guide/no-starter-kit-bom' | relative_url }}).

# Connections
{% capture notice-text %}
**Notice** 

* The earth connection has to be made first and disconnected last.
* The last connection made is the power wiring.

{% endcapture %}
<div class="notice--info">
  {{ notice-text | markdownify }}
</div>

* Connect the protective earth stud bolt with your earthing system.
* Connect the LTE antenna with the "LTE1" connector.
* Connect the Wi-Fi antenna with the "WLAN1" connector.
* Connect the GPS antenna with the "GNSS" connector.
* Connect the Ethernet cable with the "Ethernet 1" connector.
* Connect the power supply cable with ModuCop's power input. 

**Notice** In case you don't use the power cable of the Starter kit, please refer to the [user manual]({{ '/edge-solutions/moducop/quick-start-guide/powering' | relative_url }}) for the pinning of the Power Input.
{: .notice}

![ModuCop 4 slot connector]({{ '/user-docs/images/moducop/quick-start-guide/moducop-4-slot-connector.svg' | relative_url }})

# Powering
* Connect the AC power supply with your mains supply.
* The indicator LED "Power OK" lights up indicating ModuCop's internal power supply is stable.
* Your connected and powered ModuCop should look like in the picture below.

![ModuCop connected]({{ '/user-docs/images/moducop/quick-start-guide/moducop-connected.jpg' | relative_url }}){: style="width: 50%"}

# Achievements in this section
Great! ModuCop is now properly connected and powered. Now you can begin establishing the communication.




