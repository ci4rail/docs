---
title: Installation Requirements
excerpt: Installation Requirements
last_modified_at: 2021-11-30

custom_next: /edge-solutions/moducop/mounting-installation/install-guide/
---


This section gives installation requirements and guidance on how ModuCop has to be installed to enable proper and safe operation. Due to it's modularity and flexibility, ModuCop is available in various configurations and qualified for various markets. Installation requirements differ depending on ModuCop configuration.

# Installation Requirements MEC01- Models (typ. rail applications)
> Persons
  - Installation only in area with restricted access.
  - Installation and maintenance only by skilled persons.
  - Operation only by instructed persons.
{: .notice--info}

## Locations
For installation in railway vehicles, equipment location is defined according to EN50155:

|Location acc. EN50155 |Definition|Examples|
|:--- |:--- |:--- |
|Loc 1 | closed electrical operating area | interior vehicle cubicle (weather protected); exterior vehicle cubicle (weather-protected) either under-frame or upper-roof|
|Loc 2 | cabin and interiors | passenger vehicle compartment and driver cabin |

> Do not install ModuCop in other vehicle locations as specified!
{: .notice--warning}

> Please use Ci4Rail's accessories for mounting
{: .notice--info}


## External Fuse

> Do not use ModuCop without an EXTERNAL FUSE! If you are unsure, which fuse type and characteristics to choose, contact Ci4Rail.
{: .notice--danger}

The following table describes the requirements to the fuse depending on the nominal input voltage of your power system.

|Nominal Voltage |Required Fuse|
|:--------------:|:-----------:|
|24 V DC | 2.5 A medium time-lag|
|36 V DC| 1.6 A medium time-lag|
|110 V DC | 1 A medium time-lag|


# Installation Requirments MEC02- Models (Automotive / non-rail)
> Persons
  - Installation only in area with restricted access.
  - Installation and maintenance only by skilled persons.
  - Operation only by instructed persons.
{: .notice--info}

> Electrical
  - In case equipment is connected to DC mains, an all-pole mains switch in accordance shall be incorporated in the electrical installation.
  - The insulation of the protective earthing conductor shall be green-and-yellow, the minimum wire cross section is 1 mm<sup>2</sup>.
{: .notice--info}

## Locations
For installation in automotive environment, installation location has to be chosen to avoid moist, liquids and dust exposure above the limit of specified ingress protection IP20.

## External Fuse

> Do not use ModuCop without an EXTERNAL FUSE! If you are unsure, which fuse type and characteristics to choose, contact Ci4Rail.
{: .notice--danger}

The following table describes the requirements to the fuse depending on the nominal input voltage of your power system.

|Nominal Voltage |Required Fuse|
|:--------------:|:-----------:|
|12 V DC | 5 A medium time-lag|
|24 V DC | 2.5 A medium time-lag|


# General Installation Requirements

## Earthing
ModuCop is a protection class I device (protective earth).

> It is mandatory to connect protective earth first and disconnect last for any installation action!
{: .notice--danger}

Use proper components and cable equipment to establish a safe and stable earth connection.

Protective earth bolt is located on the front of installed power supply unit.

![ModuCop Edge Computer]({{ '/user-docs/images/edge-solutions/moducop/mount/prot_earth.png' | relative_url }})



## Mechanical Installation Requirements
To benefit from all ModuCop features, proper mounting in permanent vehicle installation is essential.

> Please use Ci4Rail's accessories for mounting
{: .notice--info}


### Mounting Orientation
When mounted in wall or DIN rail assembly, the following mounting orientations are possible:

Horizontal Mounting

![ModuCop Edge Computer]({{ '/user-docs/images/edge-solutions/moducop/mount/mount_horizontal1.png' | relative_url }})

Vertical Mounting

![ModuCop Edge Computer]({{ '/user-docs/images/edge-solutions/moducop/mount/mount_vertical1.png' | relative_url }})


In order to enable proper heat dissipation, the Edge Computer shall be mounted horizontally with a maximum tilt in the direction of the connector front of 30°.

![ModuCop Edge Computer]({{ '/user-docs/images/edge-solutions/moducop/mount/mounting_degree1.png' | relative_url }})


Please avoid mounting which prevents heat dissipation!

![ModuCop Edge Computer]({{ '/user-docs/images/edge-solutions/moducop/mount/mount_wrong1.png' | relative_url }})


### Keep Free Areas
Since ModuCop is completely passively cooled, the installation must allow for natural air convection through clearances with specific distances to adjacent equipment.

> Keep free areas apply to any mounting option
{: .notice--info}


The following figures show clearence areas:

- Top & bottom areas to be kept free from further installations

    ![ModuCop Edge Computer]({{ '/user-docs/images/edge-solutions/moducop/mount/keepfree_top1.png' | relative_url }})


    ![ModuCop Edge Computer]({{ '/user-docs/images/edge-solutions/moducop/mount/keepfree_ver1.png' | relative_url }})

- Left & right areas to be kept free from further installations

    ![ModuCop Edge Computer]({{ '/user-docs/images/edge-solutions/moducop/mount/din-rail-keepfree1.png' | relative_url }})



For details please refer to [Installation Guide]({{ '/edge-solutions/moducop/mounting-installation/install-guide' | relative_url }}).
