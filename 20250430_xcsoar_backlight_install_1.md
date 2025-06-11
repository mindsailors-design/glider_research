admin@raspberrypi:~ $ history | grep apt
   52  sudo apt-get install nvim
   53  sudo apt-get install neovim
   98  sudo apt-get install make g++  zlib1g-dev     libfmt-dev     libdbus-1-dev     libsodium-dev     libfreetype6-dev     libpng-dev libjpeg-dev     libtiff5-dev libgeotiff-dev     libc-ares-dev     libcurl4-openssl-dev     libssl-dev     libc-ares-dev     liblua5.4-dev     libxml-parser-perl     libasound2-dev     librsvg2-bin xsltproc     imagemagick gettext     mesa-common-dev libgl1-mesa-dev libegl1-mesa-dev     libinput-dev     fonts-dejavu
   99  sudo apt-get install libdrm-dev libgbm-dev     libgles2-mesa-dev     libinput-dev
  174  sudo apt-get install minicom
  199  sudo apt-get install pip
  202  sudo apt-get install python3-virtualenv
  261  sudo apt install pigpio python3-pigpio
  267  sudo apt install pigpio python3-pigpio
  589  sudo apt update
  590  sudo apt upgrade
  591  sudo apt install -y raspberrypi-kernel-headers build-essential git
  681  sudo apt install flex bison
  684  sudo apt install bc
  929  sudo apt update
  930  sudo apt upgrade
  992  sudo apt install raspberrypi-kernel-headers
 1047  history | grep apt


admin@raspberrypi:~ $ cat /etc/systemd/system/backlight-api.service
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

admin@raspberrypi:~/XCSoar $ history | grep mv
  134  mv XCSoar/Data/S20_SF.prf .xcsoar/

643  wget https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/input/touchscreen/cyttsp5.c?h=v6.14.4 -O cyttsp5.c
