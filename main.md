## 1. Goals of this project
To build a low cost navigation computer for use in a glider.
It should be built with readilly available components such as Raspberry Pi 4/5 and an E-ink display with touchscreen and backlight from Kobo ebook reader.
Software should be based around XC Soar, an open source glide computer:
`www.xcsoar.org`

## 1. Starting with 
## 1. Arch Linux Prep for PI4

## 1. PI 4 vs PI 5

## 1. XC Soar build from source
`xcsoar.readthedocs.io/en/latest/build.html`
git clone https://github.com/XCSoar/XCSoar
cd XCSoar/
git submodule update --init --recursive
yay -S fmt dbus libsodium freetype2 libpng libjpeg-turbo libtiff c-ares curl openssl perl-xml-parser alsa-lib librsvg libxslt imagemagick gettext mesa libinput ttf-dejavu libdrm lua
yay -S make librsvg2-bin xsltproc imagemagick gettext sox quilt zim m4 automake

## 1. Connecting BlueFly and FLARM to the PI 4/5
Both are using serial port for communication.
BlueFly uses 115200 baudrate, FLARM uses 19200.

## 1. Connecting E-ink display to PI 4

## 1. Trying writing my own epd driver from scratch based on Waveshare driver that doesn't work (not finished)

## 1. Porting E-ink driver from PI 4 to PI 5

## 1. Testing E-ink display with gui mockup

## 1. Forwarding image to the external display (not via HDMI)
https://noamzeise.com/2024/07/05/mini-monitor.html

## 1. Screen mirroring PoC to E-ink display in Python

## 1. Connecting touch panel to the PI 4 (hardware)

## 1. Connecting touch panel to the PI 4 (software)

## 1. Backlight service for Kobo display on PI4/5
