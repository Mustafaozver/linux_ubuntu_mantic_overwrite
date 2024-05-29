#!/bin/bash

if [ "$(whoami)" != root ]; then
    echo "\033[31m Bu komut çalışmak için root yetkisine ihtiyaç duyuyor."
    echo "\033[31m Önce sudo su komutu ile root olmalısınız veya sudo ön komutu ile çalıştırmalısınız."
    echo "\033[31m Örnek : '\033[35m sudo sh ./build_0.sh\033[31m ' komutunu çalıştırabilirsiniz"
    exit 1
fi

RESET_CONSOLE="\033[0m"
BACKGRUND_WHITE="\033[47m"
TEXT_BLUE="\033[31m"
STATUS_BLINK="\033[5m"
FONT_BOLD="\033[1m"

_ST="$BACKGRUND_WHITE$TEXT_BLUE$FONT_BOLD"
_FN="$RESET_CONSOLE"

#
echo "$_ST                                                    $_FN"
echo "$_ST Dahili düzenlemeler uygulanıyor...                 $_FN"
echo "$_ST                                                    $_FN"
sleep 1

##

sudo dpkg -i /setup/debs/*.deb

sudo sh ./setup_17g.sh

##


#
echo "$_ST                                                    $_FN"
echo "$_ST Dahili düzenlemeler uygulandı.                     $_FN"
echo "$_ST                                                    $_FN"

bash

sudo rm -rf /setup/*