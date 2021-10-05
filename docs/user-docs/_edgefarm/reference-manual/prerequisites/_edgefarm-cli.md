# Download `EdgeFarm CLI`

Download the latest EdgeFarm CLI. Select in `Assets` the appropriate version:
* `edgefarm.exe` for Windows
* `edgefarm` for Linux

Download the file to your personal Downloads folder.

[Get EdgeFarm CLI](https://github.com/edgefarm/edgefarm-cli/releases){: .btn .btn--info}

# Set PATH Variable

This step is necessary to call the EdgeFarm CLI from any location on your computer.

<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#Windows" role="tab" >Windows</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#Linux" role="tab">Linux</a></li>
</ul>
<div class="tab-content">
<div class="tab-pane fade in active" id="Windows" role="tabpanel" markdown="1">
Open up a command shell by pressing `Windows+R` and typing in `cmd`.

```console
> mkdir %homepath%\edgefarm
> set PATH=%PATH%;%homepath%\edgefarm
> copy %homepath%\Downloads\edgefarm.exe %homepath%\edgefarm
```

Verify that your PATH variable settings have been successfully applied by executing the EdgeFarm CLI.

```console
> edgefarm version
edgefarm-cli 06f398c1b0d1949bbeec76ca19a9b6923afe7e79
```
</div>
<div class="tab-pane fade in" id="Linux" role="tabpanel" markdown="1">
Open up a terminal and install the CLI to the `~/bin` directory.
```console
$ mkdir -p ~/bin
$ cp ~/Downloads/edgefarm ~/bin
$ echo PATH="$PATH:~/bin" >> ~/.bashrc
$ source ~/.bashrc
```

Verify that your PATH variable settings have been successfully by executing the EdgeFarm CLI.

```console
$ edgefarm version
edgefarm-cli 06f398c1b0d1949bbeec76ca19a9b6923afe7e79
```
</div>
</div> <!-- tab-content -->
