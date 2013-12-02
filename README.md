bluez-ibeacon
=============

Complete example of using [Bluez](http://www.bluez.org/) as an iBeacon.

How to use
==========

To use this example you will need to install [Bluez](http://www.bluez.org/)
either compiled by hand or through a development packaged libbluetooth. BTLE
support requires a recent version of Bluez so make sure to install the latest
version available.

After installing Bluez you can make the ibeacon binary in the bluez-beacon
directory.

For the iOS part, Fire up XCode and run the BeaconDemo app on a device that supports BTLE such
as the iPhone 5 or later. The information displayed on screen is needed to run
the Bluez beacon.

Confirm that bluetooth is up and running by typing in your console:
```
hciconfig
```

If not plese refer to this [GUIDE](http://developer.radiusnetworks.com/2013/10/09/how-to-make-an-ibeacon-out-of-a-raspberry-pi.html). Specifically Step 7.

For the iBeacon part you must compile it first, assuming you are in the root of the directory
```
cd bluez-beacon
make
```
Take the UUID displayed in the iOS app and plug it into the ibeacon executable like this:

```
sudo ./ibeacon 200 <UUID> <Major Number> <Minor Number> -29
```

If everything goes correctly you will be shown major and minor information on the device once you
have entered the region of the beacon. It can take a few seconds to register
so you may want to give it time if it doesn't pick up instantly. You may also
want to double check that the UUID is entered correctly if it doesn't seem to
work.

The passbook example uses a UUID of e2c56db5-dffb-48d2-b060-d0f5a71096e0, a
marjor number of 1 and a minor number of 1. After installing it you can use
the ibeacon program to advertise for it with the following options:

```
sudo ./ibeacon 200 e2c56db5dffb48d2b060d0f5a71096e0 1 1 -29
```

*Note*

Used both the [IOGEAR Bluetooth 4.0 USB Micro Adapter (GBU521)](http://www.amazon.com/dp/B007GFX0PY)
and the [Cirago Bluetooth 4.0 USB Mini Adapter (BTA8000)](http://www.amazon.com/dp/B0090I9NRE) successfully.

Confiremd to work on the Raspberry Pi with the IOGEAR adapter. 

License
=======

MIT - See the LICENSE file
