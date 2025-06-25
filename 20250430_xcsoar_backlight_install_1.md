## Installing dependencies for the XC Soar
```
sudo apt-get install neovim
sudo apt-get install make g++  zlib1g-dev     libfmt-dev     libdbus-1-dev     libsodium-dev     libfreetype6-dev     libpng-dev libjpeg-dev     libtiff5-dev libgeotiff-dev     libc-ares-dev     libcurl4-openssl-dev     libssl-dev     libc-ares-dev     liblua5.4-dev     libxml-parser-perl     libasound2-dev     librsvg2-bin xsltproc     imagemagick gettext     mesa-common-dev libgl1-mesa-dev libegl1-mesa-dev     libinput-dev     fonts-dejavu
sudo apt-get install libdrm-dev libgbm-dev     libgles2-mesa-dev     libinput-dev
sudo apt-get install minicom
sudo apt-get install pip
sudo apt-get install python3-virtualenv
sudo apt install pigpio python3-pigpio
sudo apt update
sudo apt upgrade
sudo apt install -y raspberrypi-kernel-headers build-essential git
sudo apt install flex bison
sudo apt install bc
sudo apt update
sudo apt upgrade
sudo apt install raspberrypi-kernel-headers
```

## Systemd service for backlight controll (python app)
admin@raspberrypi:~ $ cat /etc/systemd/system/backlight-api.service
```
[Unit]
Description=Backlight API (FastAPI app for PWM control)
After=network.target

[Service]
User=admin
WorkingDirectory=/home/admin/backlight_server_client
ExecStart=/home/admin/backlight_server_client/env/bin/uvicorn backlight_server:app --host 0.0.0.0 --port 8000
Restart=always
RestartSec=3
Environment=PYTHONUNBUFFERED=1

[Install]
WantedBy=multi-user.target
```

## Moving example XC Soar config to the previously built app
```
mv XCSoar/Data/S20_SF.prf .xcsoar/
```
## Downloading source file for the touch driver
```
wget https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/input/touchscreen/cyttsp5.c?h=v6.14.4 -O cyttsp5.c
```
