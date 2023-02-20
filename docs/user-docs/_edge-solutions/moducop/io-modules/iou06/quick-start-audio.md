---
title: IOU06 Quick-Start-Guide / Audio Demo
excerpt: Quick startup with IOU06 extension module
last_modified_at: 2022-08-10

custom_next: /edge-solutions/moducop/io-modules/iou06/detailed-description/
product_name: IOU06
article_group: S101
example_device_name: S101-IOU06-USB-EXT-1

---

# Audio Support Demo

In this demo, we'll show how to use the audio interface of the IOU06 extension module.

## Hardware
* A Moducop Edge Computer with a IOU06 installed
* A development PC (Windows or Linux), connected via Network to the Moducop
* A speaker

## Play a WAV File

This chapter describes how to play a WAV file on the audio output interface of the IOU06 without the need of any specific configuration.

### Connecting the Audio Interface to a Speaker

![Audio Connection]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/audio-out-conn.svg' | relative_url }}){: style="width: 30%"}

### Copy a WAV File to the Moducop

Connect a PC and Moducop to the same network, e.g. by using an Ethernet Switch or a Wifi Access Point and copy a WAV file to the Moducop:

```bash
scp /path/to/file.wav root@<moducop-ip>:~/file.wav
```
### Playing the WAV File

Then login into the Moducop via ssh and use the aplay command to play it:

```bash
root@moducop-cpu01: ~# aplay -D hw:0,0 ~/file.wav
```

This command will play the file on the first subdevice of the first audio card (hw:0,0).

If you have connected more than one audio card to the Moducop, you can use the `aplay -l` command to list all available audio cards and subdevices:

```bash
root@moducop-cpu01-06895147:~# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: CODEC [USB AUDIO  CODEC], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

## Loop Back the Audio Output to the Audio Input

This chapter describes how to loop back the audio output to the audio input of the IOU06 without any specific configuration.

### Connecting Loops to the Audio Interface

![Audio Connection]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/audio-in-conn.svg' | relative_url }}){: style="width: 30%"}

### Record the Audio Output

Copy a WAV file to the ModuCop as described in chapter [Copy a WAV File to the Moducop](#copy-a-wav-file-to-the-moducop).

**Attention** The WAV file must have only one channel (mono), because only one channel of the audio output interface is connected to the audio input interface.
{: .notice--warning}

Then login into the Moducop via ssh and use the arecord command to record the audio output:

```bash
root@moducop-cpu01: ~# arecord -D hw:0,0 -f S16_LE ~/record-file.wav
```

The arecord command will record the audio input of the first subdevice of the first audio card (hw:0,0) and save it to the file.wav file.

**Info**: `S16_LE` is the sample format of the audio data. You can use `arecord --help` to list all available sample formats.
{: .notice--info}

In another terminal, play the WAV file:

```bash
root@moducop-cpu01: ~# aplay -D hw:0,0 ~/file.wav
```

### Playing the Recorded Audio File

To play the recorded audio file, connect a speaker as described in chapter [Connecting the Audio Interface to a Speaker](#connecting-the-audio-interface-to-a-speaker) and use the aplay command:

```bash
root@moducop-cpu01: ~# aplay -D hw:0,0 ~/record-file.wav
```
