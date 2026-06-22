# pkg-android-platform-tools

This repository serves as a overlay for creating adbd Debian package on top of [upstream debian packaging repo](https://salsa.debian.org/android-tools-team/android-platform-tools) within the Qualcomm Linux ecosystem.

# adbd flow
The Android Debug Bridge daemon (adbd) can be used to allow communication
between a device and a computer using the ADB protocol. To that end, `adbd`
provides 2 transport means (TCP networking and USB).

Using USB method is only possible on devices providing a dual-role-capable USB
controller (simply put, `/sys/class/udc/` must contain at least one entry). It
requires setting up a USB gadget configuration using both ConfigFS and
FunctionFS, for which support must be available in the kernel running on the
device.

In order to simplify this process, a systemd service (`adbd.service`) and USB
gadget setup/activation scripts (see `adbd-usb-gadget` in the
`/usr/lib/android-sdk/platform-tools` folder) are provided by this package; by
using those, USB transport is automatically enabled on devices supporting it
without any manual intervention.

This was especially overlay adbd-usb-gadget, where  Device identifiers were 
observed to change across sessions, making device tracking unreliable. 
To ensure consistent and unique identification, update the USB product string 
to include the SoC serial number when available.
If /sys/devices/soc0/serial_number exists, append its value (in hex format) 
to the hostname and use it as the product string. Otherwise, 
fall back to the default "ADB device" string. 

# Installation Instructions

sudo dpkg -i adbd1_x.deb

# Usage
Build: To build the the package, go to Actions tab, select the Build Debian Package workflow, then 'Run workflow'

## Getting in Contact

[Report an Issue](https://github.com/qualcomm-linux/pkg-android-platform-tools/issues) on GitHub


## License

pkg-android-platform-tools is licensed under the [BSD-3-Clause License](https://spdx.org/licenses/BSD-3-Clause.html). See [LICENSE.txt](LICENSE.txt) for the full license text.
