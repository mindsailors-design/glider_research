## 1. Goals of this project
To build a low cost navigation computer for use in a glider.
It should be built with readilly available components such as Raspberry Pi 4/5 and an E-ink display with touchscreen and backlight from Kobo ebook reader.
Software should be based around XC Soar, an open source glide computer:
`www.xcsoar.org`
More on this topic [here](20250123_glider_prototype_1.md).

## 1. Starting with 
## 1. PI 4 vs PI 5
Pi 5 is newer and much more powerfull but lacks compatibility in some cases. Pi 4 is less powerfull but is compatible with XC Soar glider software and E-ink display driver out of the box.

## 1. XC Soar build from source
XC Soar runs only from the framebuffer so when using system like Raspberry Pi OS you need to use Lite version with no Desktop Environment.
Building XC Soar:
`xcsoar.readthedocs.io/en/latest/build.html`
git clone https://github.com/XCSoar/XCSoar
cd XCSoar/
git submodule update --init --recursive
yay -S fmt dbus libsodium freetype2 libpng libjpeg-turbo libtiff c-ares curl openssl perl-xml-parser alsa-lib librsvg libxslt imagemagick gettext mesa libinput ttf-dejavu libdrm lua
yay -S make librsvg2-bin xsltproc imagemagick gettext sox quilt zim m4 automake

## 1. Connecting BlueFly and FLARM to the PI 4/5
Both are using serial port for communication.
BlueFly uses 115200 baudrate, FLARM uses 19200.
[FLARM pinout](202501114_flarm_pinout_1.md)

## 1. Connecting E-ink display to PI 4
E-ink display driver based on IT8951 driver IC communicates with Raspberry Pi via SPI (MISO, MOSI, SCK, CS) with additional RESET and HARDWARE_READY pins.

## 1. Trying writing my own epd driver from scratch based on Waveshare driver that doesn't work (not finished)
Based on driver provided by Waveshare (but I didn't manage to get it to work):
(Waveshare E-ink C driver)[https://www.waveshare.com/wiki/6inch_HD_e-Paper_HAT#Working_with_Raspberry_Pi_.28SPI.29]
[E-ink C driver repo](https://bitbucket.org/mindsailors/it8951e_c_driver/src/main/)

## 1. Porting E-ink driver from PI 4 to PI 5
Raspberry Pi 5 lacks support for GPIO libraries used on the Raspberry Pi 4 so to get that driver to work you need to make few changes and install different GPIO library.

## 1. Testing E-ink display with gui mockup
[GUI mockup on epd display](https://bitbucket.org/mindsailors/epd_gui_mockup/src/master/)
It is just a simple Python script that uses PyGame to create a window with some graphics and random numbers to be a XC Soar look-a-like.
Then I put this code into a [epd_driver](https://bitbucket.org/mindsailors/it8951_epd_driver/src/master/) as a `gui_mockup.py`. To run it you need to adjust some paths in 'main()' function because they are direct paths and not relative. You can try few different types of images with different 'Display Modes'.

## 1. Forwarding image to the external display (not via HDMI)
[Forwarding to LCD via SPI](https://noamzeise.com/2024/07/05/mini-monitor.html)

## 1. Screen mirroring PoC to E-ink display in Python


## 1. Connecting touch panel to the PI 4 (hardware)


## 1. Connecting touch panel to the PI 4 (software)
## 1. Arch Linux Prep for PI4
Switching from Raspberry Pi OS to Arch Linux on ARM because of touch driver compatibility issues.
I was able to find a driver for TT21000 touch controller found in Kobo Clara HD and it is available [here](https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/input/touchscreen/cyttsp5.c?h=v6.14.4).
The issue is that, as far as I know, because of kernel version incompatibilities it's not yet included into Raspbery Pi OS and I wasn't able to succesfully build it and include it into the kernel.

[arch on arm install](20250514_arch_on_arm_install.md)



## 1. Backlight service for Kobo display on PI4/5
[Backlight service and client](https://bitbucket.org/mindsailors/backlight_server_client/src/master/)
Backlight in the Kobo display consists of two rows of leds: one warm and one cold. By changing their current you can adjust their brightness and thus you can adjust the overall color temperature and brightness.
