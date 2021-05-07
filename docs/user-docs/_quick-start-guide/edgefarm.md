---
title: Edgefarm
excerpt: Edgefarm
last_modified_at: 2021-05-06

custom_next:  /quick-start-guide/edgefarm/basic-functions/
---

This page gives an overview of EdgeFarm's services.

EdgeFarm consists of three major parts:
1. Device Lifecycle Management (DLM)
2. Application Lifecycle Management (ALM)
3. Application Data Service (ADS)

# Device Lifecycle Management

EdgeFarm DLM manages edge devices and provides functionality to easily update the firmware of the devices.
The firmware update contains a new Yocto Linux image especially built for the hardware platform.

# Application Lifecycle Management

EdgeFarm ALM manages applications that can easily deployed on the edge devices. Those applications are packed as Docker Images and can easily managed using the ALM service. There are some base applications for specific sensors or bus systems that customer applications can obtain data from.

# Application Data Service

EdgeFarm ADS provides a way for customers to collect and use the data produced by the edge devices.