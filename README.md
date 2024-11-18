# Raspberry Pi Boot Analysis

Raspberry Pi Boot Analysis Service

The Raspberry Pi Boot Analysis Service gathers boot-up performance information
that can be used to decipher the interdependencies of various boot services and
determine the critical-path to boot-up. The service runs automatically after
each boot and collates performance statistics gathered using a variety of tools
(such as
[`systemd-analyze(1)`](https://www.freedesktop.org/software/systemd/man/latest/systemd-analyze.html))
into a single report.

- To install on Raspberry Pi OS, use `sudo apt update && sudo apt install
  rpi-analyse-boot`.
- Reboot the device to generate a boot analysis.

## How to use Raspberry Pi Boot Analysis

Once installed, you will find the launcher "Raspberry Pi Boot Analysis" in the
main menu under "Accessories"; selecting it will open the boot report
(`/run/rpi-analyse-boot.service/index.html') in your default browser.
Alternatively, the boot report file can be copied for viewing elsewhere.

If the [`rpi-trace-boot`](https://github.com/raspberrypi/rpi-trace-boot)
package has also been installed, the boot analysis report will contain an
embedded [Perfetto](https://perfetto.dev) boot trace.

## Building

On Raspberry Pi OS:
```
dpkg-buildpackage -uc -us
sudo dpkg -i ../rpi-analyse-boot_<version>_all.deb
```
