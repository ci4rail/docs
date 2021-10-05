---
title: git
excerpt: Instructions how to install git
last_modified_at: 2021-07-28
toc: false
---

This section shows how to install git.

<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#windows" role="tab" >Windows</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#linux" role="tab">Linux</a></li>
</ul>

<div class="tab-content">
<div class="tab-pane fade in active" id="windows" role="tabpanel" markdown="1">

**Pre-Condition**

* Windows 10

> **Note: It is highly recommended using `Windows 10`. Other Windows versions are not guranteed to work.**
<!-- {: .notice--warning} -->

**Install**

Download Git for Windows and select `64-bit Git for Windows Setup`. Follow the steps for installation.

[Get Git for Windows](https://git-scm.com/download/win){: .btn .btn--info}

After installing Git for Windows open up `git-bash`.

![Starting git-bash]({{ 'user-docs/images/edgefarm/reference-manual/prerequisites/start-git-bash.png' | relative_url }} "Starting git-bash"){: style="width: 40%"}

After that enter the following command. This keeps the original line endings that are needed for the system to work correctly.

```console
  git config --global core.autocrlf false
```

![Configure git line endings]({{ 'user-docs/images/edgefarm/reference-manual/prerequisites/git-bash.png' | relative_url }} "Configure git line endings"){: style="width: 50%"}

You are now ready to use git.
</div>
<div class="tab-pane fade in" id="wsl2_installation" role="tabpanel" markdown="1">

</div>
<div class="tab-pane fade in" id="linux" role="tabpanel" markdown="1">

**Pre-Condition**

* Ubuntu 20.04

> **Note: The following steps have been tested with Ubuntu 20.04 under `amd64`, but other Linux distributions and CPU architectures like Raspberry Pi with Raspbian may also work.**
<!-- {: .notice--info} -->

**Install**

```console
$ sudo apt update
$ sudo apt install git
```

</div>
</div> <!-- tab-content -->
