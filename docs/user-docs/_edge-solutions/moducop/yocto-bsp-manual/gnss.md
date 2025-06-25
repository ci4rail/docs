---
title: GNSS Receiver
excerpt: How to use the GNSS receiver of the ModuCop Edge Computer
order: 70
custom_previous: /edge-solutions/moducop/yocto-bsp-manual/partition-concept/
custom_next: /edge-solutions/moducop/yocto-bsp-manual/rootfs-ota-update/
---

The ModuCop has U-Blox NEO-8MU GNSS receiver on board, which can be used to get position and time information. The GNSS receiver is connected via USB to the CPU, and it is supported by the [GPSD](https://gpsd.gitlab.io/gpsd/) daemon.

## Antenna requirements

The GNSS receiver requires an external ***active*** antenna to receive signals from the satellites. The antenna must be connected to the GNSS antenna connector on the front panel of the ModuCop. The connector is a standard SMA connector, so you can use any compatible GNSS antenna.

## Verify GNSS receiver is working

With some simple shell commands, you can verify that the GNSS receiver is working and providing position and time information.

```bash
nc localhost 2947
```
This command connects to the GPSD daemon and allows you to send commands to it. You can then send the `?WATCH={"enable":true,"json":true}` command to enable the GPSD daemon to send position and time information in JSON format.

You should see a response like this:

```
{"class":"TPV","device":"/dev/ttyACM0","status":2,"mode":3,"time":"2025-06-25T19:09:40.000Z","leapseconds":18,"ept":0.005,"lat":49.430784600,"lon":11.070984800,"altHAE":360.1200,"altMSL":313.1150,"alt":313.1150,"epx":2.766,"epy":2.365,"epv":5.204,"track":74.2647,"magtrack":77.5310,"magvar":3.3,"speed":0.038,"climb":-0.146,"eps":5.53,"epc":10.42,"ecefx":4079043.42,"ecefy":798131.53,"ecefz":4822127.37,"ecefvx":-0.05,"ecefvy":-0.04,"ecefvz":-0.03,"ecefpAcc":6.48,"ecefvAcc":0.35,"geoidSep":46.484,"eph":3.863,"sep":7.786}
{"class":"SKY","device":"/dev/ttyACM0","time":"2025-06-25T19:09:41.000Z","xdop":0.74,"ydop":0.63,"vdop":1.32,"tdop":1.02,"hdop":0.97,"gdop":1.93,"pdop":1.64,"nSat":30,"uSat":12,"satellites":[{"PRN":5,"el":56.0,"az":283.0,"ss":21.0,"used":false,"gnssid":0,"svid":5,"health":1},{"PRN":7,"el":47.0,"az":61.0,"ss":36.0,"used":true,"gnssid":0,"svid":7,"health":1},{"PRN":8,"el":6.0,"az":63.0,"ss":28.0,"used":false,"gnssid":0,"svid":8,"health":1},{"PRN":9,"el":13.0,"az":104.0,"ss":34.0,"used":true,"gnssid":0,"svid":9,"health":1},{"PRN":11,"el":5.0,"az":216.0,"ss":16.0,"used":false,"gnssid":0,"svid":11,"health":1},{"PRN":13,"el":43.0,"az":286.0,"ss":28.0,"used":true,"gnssid":0,"svid":13,"health":1},{"PRN":14,"el":32.0,"az":156.0,"ss":35.0,"used":true,"gnssid":0,"svid":14,"health":1},{"PRN":15,"el":9.0,"az":293.0,"ss":21.0,"used":false,"gnssid":0,"svid":15,"health":1},{"PRN":18,"el":9.0,"az":332.0,"ss":18.0,"used":false,"gnssid":0,"svid":18,"health":1},{"PRN":20,"el":55.0,"az":223.0,"ss":30.0,"used":true,"gnssid":0,"svid":20,"health":1},{"PRN":21,"el":62.0,"az":205.0,"ss":32.0,"used":false,"gnssid":0,"svid":21,"health":2},{"PRN":22,"el":18.0,"az":167.0,"ss":32.0,"used":true,"gnssid":0,"svid":22,"health":1},{"PRN":27,"el":5.0,"az":30.0,"ss":33.0,"used":false,"gnssid":0,"svid":27,"health":1},{"PRN":30,"el":82.0,"az":88.0,"ss":33.0,"used":true,"gnssid":0,"svid":30,"health":1},{"PRN":36,"el":32.0,"az":164.0,"ss":0.0,"used":false,"gnssid":1,"svid":123,"health":1},{"PRN":40,"el":20.0,"az":128.0,"ss":31.0,"used":false,"gnssid":1,"svid":127},{"PRN":41,"el":3.0,"az":104.0,"ss":0.0,"used":false,"gnssid":1,"svid":128},{"PRN":49,"el":33.0,"az":188.0,"ss":30.0,"used":false,"gnssid":1,"svid":136,"health":1},{"PRN":194,"el":1.0,"az":36.0,"ss":0.0,"used":false,"gnssid":5,"svid":2,"health":1},{"PRN":65,"el":50.0,"az":318.0,"ss":0.0,"used":false,"gnssid":6,"svid":1,"health":1},{"PRN":66,"el":3.0,"az":306.0,"ss":0.0,"used":false,"gnssid":6,"svid":2,"health":1},{"PRN":71,"el":15.0,"az":119.0,"ss":31.0,"used":true,"gnssid":6,"svid":7,"health":1},{"PRN":72,"el":64.0,"az":98.0,"ss":31.0,"used":true,"gnssid":6,"svid":8,"health":1},{"PRN":73,"el":22.0,"az":34.0,"ss":29.0,"used":true,"gnssid":6,"svid":9,"health":1},{"PRN":74,"el":64.0,"az":67.0,"ss":22.0,"used":true,"gnssid":6,"svid":10,"health":1},{"PRN":75,"el":48.0,"az":180.0,"ss":34.0,"used":true,"gnssid":6,"svid":11,"health":1},{"PRN":81,"el":16.0,"az":321.0,"ss":0.0,"used":false,"gnssid":6,"svid":17,"health":1},{"PRN":82,"el":7.0,"az":5.0,"ss":0.0,"used":false,"gnssid":6,"svid":18,"health":1},{"PRN":88,"el":7.0,"az":270.0,"ss":19.0,"used":false,"gnssid":6,"svid":24,"health":1},{"PRN":91,"el":15.0,"az":119.0,"ss":0.0,"used":false,"gnssid":6,"svid":27,"health":1}]}
```

If you see a `TPV` with a `lat` and `lon` value, it means that the GNSS receiver is working and providing position information. The `time` field shows the current time in UTC.

## Socket Protection

The BSP configures IPTables to protect the GPSD socket from unauthorized access. The socket is only accessible from the local machine and containers, so you cannot access it from outside the ModuCop.
