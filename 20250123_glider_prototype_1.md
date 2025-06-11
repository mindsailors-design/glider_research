# Glider navigation computer overview

## Features
* 1448x1072 E paper display with touch panel and backlight,
* IT8951 driver board between the display and the Raspberry Pi,
* Based on Raspberry Pi 5 with Raspberry Pi OS,
* Needs to autostart with the system, without a monitor plugged in,
* Ideally needs to work with touchpanel and backlight,
* Goal is to achieve at least 5 fps without annoying blinking,

## Hardware
### E paper display
Based on display from Cobo ebook reader. \
Cobo MPN: \
*ED060KH6*
Datasheet: \
The closest display to the one in the Cobo Clara HD:
https://www.panelook.com/ED060KG1_E_Ink_6.0_EPD_overview_25549.html
Another close one, same resolution, touch panel and backlight but coloured one, no grayscale: \
https://www.panelook.com/SA1452-FOA_E_Ink_6.0_EPD_overview_49310.html


### E paper driver board
IT8951 Datasheet: \
https://download.kamami.pl/p586054-IT8951_D_V0.2.4.3_20170728.pdf
IT8951 Programming Guide: \
https://v4.cecdn.yun300.cn/100001_1909185148/IT8951_I80+ProgrammingGuide_16bits_20170904_v2.7_common_CXDX.pdf
IT8951 Driver Board Dev Kit: \
https://www.waveshare.com/6inch-HD-e-Paper-HAT.htm
IT8951 Adafruit Wiki; \
https://www.waveshare.com/wiki/6inch_HD_e-Paper_HAT#Working_with_Raspberry_Pi_.28SPI.29
IT8951 Driver Board Schematic: \
https://files.waveshare.com/upload/2/27/E-Paper-IT8951-Driver-HAT-B-Schematic.pdf.pdf

## Software
Software should consist of at least two parts: \
* E paper display driver, \
* Desktop screenshot module
* Some form of scheduling of making screenshots and displaying them
* needs to check if X display server is up and running
* Raspberry Pi needs to display desktop without the monitor connected to the Pi (force_hotplug etc.)
* 

### Proof of concept
First version was made just to check if it is possible to take a screenshot of what is currently displayed on the desktop
and send it to the e paper display. \
Application was made with Python, mss was used for taking screenshots, Pillow was used for handling image buffers. Communication 
with the display is done with driver mentioned below.

### E paper display driver
Python driver working on Pi 4, not compatible with Pi 5. Needs a different SPI driver.
https://github.com/GregDMeyer/IT8951/tree/master

Software provided by Waveshare does not work.

### Screenshot making library
Raspberry Pi Os needs to be switched to X11 (using raspi-config). \
Screen mirroring is basically two things: take a screenshot and send it to the display.

## Raspberry Pi 5 pinout
 +-----+-----+---------+------+---+---Pi 4B--+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 |     |     |    3.3v |      |   |  1 || 2  |   |      | 5v      |     |     |
 |   2 |   8 |   SDA.1 |   IN | 1 |  3 || 4  |   |      | 5v      |     |     |
 |   3 |   9 |   SCL.1 |   IN | 1 |  5 || 6  |   |      | 0v      |     |     |
 |   4 |   7 | GPIO. 7 |   IN | 1 |  7 || 8  | 1 | IN   | TxD     | 15  | 14  |
 |     |     |      0v |      |   |  9 || 10 | 1 | IN   | RxD     | 16  | 15  |
 |  17 |   0 | GPIO. 0 |  OUT | 1 | 11 || 12 | 0 | IN   | GPIO. 1 | 1   | 18  |
 |  27 |   2 | GPIO. 2 |   IN | 0 | 13 || 14 |   |      | 0v      |     |     |
 |  22 |   3 | GPIO. 3 |   IN | 0 | 15 || 16 | 0 | IN   | GPIO. 4 | 4   | 23  |
 |     |     |    3.3v |      |   | 17 || 18 | 1 | IN   | GPIO. 5 | 5   | 24  |
 |  10 |  12 |    MOSI | ALT0 | 0 | 19 || 20 |   |      | 0v      |     |     |
 |   9 |  13 |    MISO | ALT0 | 0 | 21 || 22 | 0 | IN   | GPIO. 6 | 6   | 25  |
 |  11 |  14 |    SCLK | ALT0 | 0 | 23 || 24 | 1 | OUT  | CE0     | 10  | 8   |
 |     |     |      0v |      |   | 25 || 26 | 1 | OUT  | CE1     | 11  | 7   |
 |   0 |  30 |   SDA.0 |   IN | 1 | 27 || 28 | 1 | IN   | SCL.0   | 31  | 1   |
 |   5 |  21 | GPIO.21 |   IN | 1 | 29 || 30 |   |      | 0v      |     |     |
 |   6 |  22 | GPIO.22 |   IN | 1 | 31 || 32 | 0 | IN   | GPIO.26 | 26  | 12  |
 |  13 |  23 | GPIO.23 |   IN | 0 | 33 || 34 |   |      | 0v      |     |     |
 |  19 |  24 | GPIO.24 |   IN | 0 | 35 || 36 | 0 | IN   | GPIO.27 | 27  | 16  |
 |  26 |  25 | GPIO.25 |   IN | 0 | 37 || 38 | 0 | IN   | GPIO.28 | 28  | 20  |
 |     |     |      0v |      |   | 39 || 40 | 0 | IN   | GPIO.29 | 29  | 21  |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+---Pi 4B--+---+------+---------+-----+-----+
SPI on pins 10, 9, 11 (MOSI, MISO, SCLK)

## Touch Panel
Connected with I2C, with Reset and Interrupt pin. 3.3V power supply.

## Backlight
Two rows of LEDs, both typ. 17.1V @ 20mA.

## Inspiration
This project does exactly what we need but on a small lcd display, not a e paper one.
https://noamzeise.com/2024/07/05/mini-monitor.html
https://github.com/NoamZeise/pi-spi-display/tree/master
