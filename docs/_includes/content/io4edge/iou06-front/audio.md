## Audio Interface

### Alsa Configuration

The audio devices can be configured with the /etc/asound.conf file. By default, the following configuration is installed on the moducop:

```
# definition for the audio stereo output using the plug plugin for rate conversion
pcm.out_stereo {
    type plug
    slave.pcm "out_dmix"
}
# definition for the left output channel using the plug plugin for rate conversion
pcm.out_left {
    type plug
    slave.pcm "out1_dmix"
}
# definition for the right output channel using the plug plugin for rate conversion
pcm.out_right {
    type plug
    slave.pcm "out2_dmix"
}
# definition for the audio input using the plug plugin for rate conversion
pcm.in {
    type plug
    slave.pcm "in_dsnoop"
}

pcm_slave.io4edge_audio {
  pcm "hw:0,0"
  rate 48000
  channels 2
}

pcm.out_dmix {
  type dmix
  ipc_key 4242
  slave io4edge_audio
}

pcm.out1_dmix {
  type dmix
  ipc_key 4242
  slave io4edge_audio
  bindings.0 0
}

pcm.out2_dmix {
  type dmix
  ipc_key 4242
  slave io4edge_audio
  bindings.0 1
}

pcm.in_dsnoop {
  type dsnoop
  ipc_key 4242
  slave io4edge_audio
  bindings.0 0
}
```

**Information** The `ipc_key` parameter is used to identify the shared memory segment. It must be the same for all audio devices that should be connected to each other. The `bindings.0 0` parameter is used to specify the channel that should be used for the device. The first channel is 0, the second channel is 1. A detailed description of the configuration can be found on the official [Alsa Website](https://www.alsa-project.org/wiki/Asoundrc).
{: .notice--info}

#### Stereo Output

To use the stereo output, the following command can be used:

```bash
root@moducop-cpu01: ~# aplay -D out_stereo /path/to/file.wav
```

#### Mono Outputs (Left Channel/Right Channel)

To use the left channel output, the following commands can be used:

```bash
root@moducop-cpu01: ~# aplay -D out_left /path/to/file.wav
```

To use the right channel output, the following commands can be used:

```bash
root@moducop-cpu01: ~# aplay -D out_right /path/to/file.wav
```

#### Mono Input

To use the mono input, the following command can be used:

```bash
root@moducop-cpu01: ~# arecord -D in /path/to/record-file.wav
```

### Adapt Volume with Alsa

To adapt the volume of the audio output, the interactive command line tool `alsamixer` can be used:

```bash
root@moducop-cpu01: ~# alsamixer
```
![Alsamixer]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/alsamixer.png' | relative_url }})

With the up and down arrow keys, the volume can be adjusted and the changes are immediately applied to the audio output.

**Attention** If you have connected more than one audio card to the Moducop, you can use the left and right arrow keys to switch between the different cards.
{: .notice--warning}

### Alsa State

The settings defined in alsamixer is stored in the file `/etc/alsa/asound.state`. This file is automatically loaded by the alsa-state daemon at startup.
