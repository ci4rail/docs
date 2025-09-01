---
title: UWB Setup
excerpt: Setting up the UWB infrastructure for the Lyve Demo Kit
---

To setup the UWB infrastructure, you need to the "User Manual Easyplan", which is available online for download
at [Pinpoint Cloud](https://connect.pinpoint.de/).
It's currently accessible only for customers of the LYVE Demo Kit. The credentials to access it will be provided by your LYVE contact.

"User Manual Easyplan" describes in detail what to do, but here is a brief summary:

* Launch Easyplan
* Define your UWB Area in Easyplan by creating a building and a floor
* Upload your floor plan into Easyplan
* Plan the Satlet positions in Easyplan
* Flash the configuration into Satlets
* Install the Satlets to their designated positions
* Verify the correct installation using the Checklet
* Geo-Reference your site
* Configure Easyplan to receive positioning data

## Configure Easyplan to receive positioning data

Click on the cogwheel icon in the top right corner to access the settings.

![Cogwheel](/user-docs/images/lyve/easyplan-cogwheel.png){: style="width: 30%"}

In the settings dialog, select `TCP` and enter port `11002`.
This is the port which is used by the redpanda-connect-kyt container to send positioning data to Easyplan.

![Remote Positioning Setup](/user-docs/images/lyve/easyplan-remote-positioning-config.png){: style="width: 50%"}
