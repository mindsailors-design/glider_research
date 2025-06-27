## 1. Goals of this project
To build a low cost navigation computer for use in a glider.
It should be built with readilly available components such as Raspberry Pi 4/5 and an E-ink display with touchscreen and backlight from Kobo ebook reader.
Software should be based around XC Soar, an open source glide computer:
`www.xcsoar.org`
More on this topic [here](20250123_glider_prototype_1.md).

## 1. Overview, what works on what operating system
| Feature                      | Raspberry Pi OS | Arch Linux on ARM |
| --------                     | :-----------:   | :-----------:     |
| Framebuffer mirroring to EPD |       ✅        |       ❓          |
| Building and running XC Soar |       ✅        |        ❌         |
| Touchscreen support          |       ❌        |        ❌         |

✅ - tested and working
❌ - tested and not working
❓ - untested

## 1. PI 4 vs PI 5
Pi 5 is newer and much more powerfull but lacks compatibility in some cases. Pi 4 is less powerfull but is compatible with XC Soar glider software and E-ink display driver out of the box.

## 2. XC Soar build from source
XC Soar runs only from the framebuffer so when using system like Raspberry Pi OS you need to use Lite version with no Desktop Environment.
Building XC Soar:
`xcsoar.readthedocs.io/en/latest/build.html`
`
git clone https://github.com/XCSoar/XCSoar
cd XCSoar/
git submodule update --init --recursive
`
I succesfully built it on Raspberry Pi OS from the instructions above. Below are some steps for Arch Linux but they are incomplete as I didn't have enough time to dig into what packages are missing (that's what I stopped at).
`
yay -S fmt dbus libsodium freetype2 libpng libjpeg-turbo libtiff c-ares curl openssl perl-xml-parser alsa-lib librsvg libxslt imagemagick gettext mesa libinput ttf-dejavu libdrm lua
yay -S make librsvg2-bin xsltproc imagemagick gettext sox quilt zim m4 automake
`
## 3. Connecting BlueFly and FLARM to the PI 4/5
BlueFly is a variometer used for measuring vertical speed and altitude based on atmospheric pressure: [BlueFly](https://www.blueflyvario.com/)
Flarm is the collision warning system for general aviation and drones: [Flarm](https://www.flarm.com/en/)
Both are using serial port for communication.
BlueFly uses 115200 baudrate, FLARM uses 19200.
[FLARM pinout](20250114_flarm_pinout_1.md)

## 4. Connecting E-ink display to PI 4
E-ink display driver based on IT8951 driver IC communicates with Raspberry Pi via SPI (MISO, MOSI, SCK, CS) with additional RESET and HARDWARE_READY pins.
Here is a link to the module and the display that were used during testing:
[1448x1072, 6" E-ink display and driver](https://www.waveshare.com/product/displays/e-paper/epaper-1/6inch-hd-e-paper-hat.htm)
[Here is the wiki page for that display and driver combo.](https://www.waveshare.com/wiki/6inch_e-Paper_HAT)

## 5. Trying writing my own epd driver from scratch based on Waveshare driver that doesn't work (not finished)
Based on driver provided by Waveshare (but I didn't manage to get it to work):
[Waveshare E-ink C driver](https://www.waveshare.com/wiki/6inch_HD_e-Paper_HAT#Working_with_Raspberry_Pi_.28SPI.29)
[E-ink C driver repo](https://github.com/mindsailors-design/it8951e_c_driver.git)

## 6. Porting E-ink driver from PI 4 to PI 5
Raspberry Pi 5 lacks support for GPIO libraries used on the Raspberry Pi 4 so to get that driver to work you need to make few changes and install different GPIO library.
This is the original e-ink driver GitHub repository that works well on Raspberry Pi 4:
[E-ink driver for RPi 4](https://github.com/GregDMeyer/IT8951)
And here is my fork of it with different GPIO library that is supported on Raspberry Pi 5:
[E-ink driver for RPi 5](https://github.com/mindsailors-design/it8951_epd_driver.git)

## 7. Testing E-ink display with gui mockup
[GUI mockup on epd display](https://github.com/mindsailors-design/epd_gui_mockup.git)
It is just a simple Python script that uses PyGame to create a window with some graphics and random numbers to be a XC Soar look-a-like.
Then I put this code into a [epd_driver](https://github.com/mindsailors-design/it8951_epd_driver.git) as a `gui_mockup.py`. To run it you need to adjust some paths in 'main()' function because they are direct paths and not relative. You can try few different types of images with different 'Display Modes'.

## 8. Forwarding image to the external display (not via HDMI)
[Forwarding to LCD via SPI](https://noamzeise.com/2024/07/05/mini-monitor.html)
This project uses Raspberry Pi Zero, a 3.5" LCD display and a clever software. It copies content of the framebuffer and sends it via SPI to the LCD. For that to work, RPi needs to think HDMI cable is always connected and Raspberry Pi OS must be switched to running on X11 (I couldn't find a way to copy framebuffer of Wayland).

## 9. Screen mirroring PoC to E-ink display in Python
[Screen mirroring to E-ink PoC](https://github.com/mindsailors-design/epd_mirror_poc/tree/master) \
Modified version of E-ink driver from above with added functionalities for periodically taking a screenshot and sending it to e-paper display. Also it has some code for taking screenshots using two different ways on X11 and a systemd service file for running it from the system startup.

## 10. Connecting touch panel to the PI 4 (hardware)
Kobo Clara HD uses TT21000 as a touchscreen controller. It uses 4 pins for communication with a master: 2 for I2C (SDA, SCL) Reset and Interrupt Request. Raspberry Pi 4 and 5 has I2C on GPIO header (pins 2 and 3), Reset and IRQ can be connected to other non-used GPIO. You probably also need pull-up resistors the I2C lines.

## 11. Connecting touch panel to the PI 4 (software)
I was able to find a driver for TT21000 touch controller found in Kobo Clara HD and it is available [here](https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/input/touchscreen/cyttsp5.c?h=v6.14.4).
The issue is that, as far as I know, because of kernel version incompatibilities it's not yet included into Raspbery Pi OS and I wasn't able to succesfully build it and include it into the kernel.

That's why I decided to use different operating system with newer kernel that could support this touch driver. I chose Arch Linux on Arm (see below for how to install Arch on RPi 4).

On Arch Linux I managed to build this driver without issues but still couldn't include it into the kernel. Arch on Arm uses U-boot and I tried patching the base DTB with overlay for using cyttsp5 (touch driver) but failed (I'm not sure what went wrong so good luck).

## 12. Arch Linux Prep for PI4
Switching from Raspberry Pi OS to Arch Linux on ARM because of touch driver compatibility issues.
[arch on arm install](20250514_arch_on_arm_install_1.md)

## 13. Backlight service for Kobo display on PI4/5
[Backlight service and client](https://github.com/mindsailors-design/backlight_server_client.git)
Backlight in the Kobo display consists of two rows of leds: one warm and one cold. By changing their current you can adjust their brightness and thus you can adjust the overall color temperature and brightness.
