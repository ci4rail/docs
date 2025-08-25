---
title: Overview
excerpt: Overview of LYVE - Localize Your Vehicle
last_modified_at: 2023-08-11
---

WELCOME to LYVE user documentation.

LYVE is an open, high-precision positioning solution for vehicles (rail vehicles as well as buses) and other powered assets and enables highly accurate client-side positioning in depots, areas with limited satellite visibility (e.g. stations, tunnels) and daily operations.

By using different localization technologies, LYVE allows seamless self-positioning in indoor as well as outdoor areas with sub-meter accuracy.

![Lyve Tracelet]({{ '/user-docs/images/lyve/lyve_overview.png' | relative_url }})


LYVE consists of infrastructure components as well as equipment installed in the vehicle (Tracelet) and combines the positioning technologies GNSS / RTK (real-time kinematics) and UWB (ultra wide band) in one solution. LYVE consistently follows the approach of position calculation in the moving asset. This eliminates the need for complex and costly localization servers on the land side.
The on-board components are qualified for use in buses (E-Mark) and trains (EN50155); however, the positioning solution is not limited to these industries or to vehicles due to its consistent application of standards. The technologies used can also be used for passenger tracking (smartphone), for example.

The following sections show the user documentation of each kind.


|             LYVE Components                                |   Description    |
| ---------------------------------------------------------- | ------------------------------------------------------------------------ |
| [Tracelet]({{ '/lyve/lyve-tracelets/'   | relative_url }}) | Vehicle components for seamless localization indoor and outdoor          |
| [Infrastructure]({{ '/lyve/lyve-infra/' | relative_url }}) | Infrastructur components for indoor localization and depot communication |
| [Demokit]({{ '/lyve/lyve-demo-kit/' | relative_url }}) | Development kit for testing LYVE components          |
