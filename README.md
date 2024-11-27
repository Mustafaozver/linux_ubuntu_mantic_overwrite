# Linux Kurulum (Ubuntu 23 - mantic)

---

## Kurucu System İçin Bağımlılıklar :

[[CLİNUX/Bağımlılıklar|Bağımlılıklar]]
,

```bash
sudo apt update
sudo apt install grub-efi-amd64 -y
sudo apt install debootstrap -y
sudo apt install arch-install-scripts -y
sudo apt install pacman-package-manager -y

sudo loadkeys trq.map
```

## Formatlama

[[CLİNUX/Formatlama|Formatlama:Formatlama]]
,
476.94 GB Boyutundaki /dev/nvme0n1 Bölümü için :

| Bölüm          | Türü | Tür Kodu | Yol        | Boyut             | İlk Sektör | Son Sektör |
| -------------- | ---- | -------- | ---------- | ----------------- | ---------- | ---------- |
| /dev/nvme0n1p1 | UEFI | 1        | /boot/efi/ | 1G                | Boş Bırak  | +1G        |
| /dev/nvme0n1p2 | BOOT | 20       | /boot/     | 4 GB              | Boş Bırak  | +4G        |
| /dev/nvme0n1p3 | SWAP | 19       | -          | 16 GB (RAM Kadar) | Boş Bırak  | +16G       |
| /dev/nvme0n1p4 | ROOT | 23       | /          | 200 GB            | Boş Bırak  | +200G      |
| /dev/nvme0n1p5 | HOME | 42       | /home/     |                   | Boş Bırak  | Boş Bırak  |

``` bash

lsblk # diskleri öğrenmek için
blkid # bölümleri öğrenmek için

sudo fdisk /dev/nvme0n1

# g: GPT,  n: NEW t: TYPE
# t 1 : UEFI
# t 20 : BOOT, Linux FS
# t 19 : SWAP
# t 23 : ROOT
# t 42 : HOME

```

```bash
sudo mkswap /dev/nvme0n1p3
sudo swapon /dev/nvme0n1p3


sudo mkfs.vfat /dev/nvme0n1p1
sudo mkfs.ext4 /dev/nvme0n1p2
sudo mkfs.btrfs /dev/nvme0n1p4
sudo mkfs.ext4 /dev/nvme0n1p5

```

## Mount İşlemleri

[[CLİNUX/Mount İşlemleri|Mount İşlemleri]]

,

```bash

# sudo cryptsetup luksFormat /dev/nvme0n1p4
# sudo cryptsetup luksOpen /dev/nvme0n1p4 crypto_root
# sudo mkfs.btrfs /dev/mapper/crypto_root

sudo mount /dev/nvme0n1p4 /mnt
sudo btrfs su cr /mnt/@

#sudo btrfs su cr /mnt/@home

# btrfs su cr /mnt/@usr
# btrfs su cr /mnt/@tmp
# btrfs su cr /mnt/@etc
# btrfs su cr /mnt/@var
# btrfs su cr /mnt/@opt

sudo umount -R /mnt


sudo mount -t btrfs -o noatime,compress=lzo,space_cache=v2,subvol=@ /dev/nvme0n1p4 /mnt


# sudo mount -t btrfs -o noatime,compress=zstd,space_cache,discard=async,subvol=@ /dev/nvme0n1p4 /mnt


sudo chmod 777 /mnt


sudo mkdir -p /mnt/home
sudo mkdir -p /mnt/boot

sudo mount /dev/nvme0n1p5 /mnt/home
sudo mount /dev/nvme0n1p2 /mnt/boot

sudo mkdir -p /mnt/boot/efi
sudo mount /dev/nvme0n1p1 /mnt/boot/efi

# görmek için
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY KDE_SESSION_VERSION=5 KDE_FULL_SESSION=true dolphin

# bölüm UUID elde etmek için
blkid -s UUID -o value /dev/nvme0n1p4

```

## Temel System Kurulumu : Debootstrap

[[CLİNUX/debootstrap|debootstrap]]
 - mantic
 - noble
 - bookworm

```bash

##ubuntu mnatic veya noble
sudo debootstrap noble /mnt/

sudo su

for dir in sys dev proc ; do mount --rbind /$dir /mnt/$dir && mount --make-rslave /mnt/$dir ; done

sudo chroot /mnt apt update
sudo chroot /mnt apt upgrade -y
sudo chroot /mnt apt dist-upgrade -y

sudo mkdir -p /mnt/0/
sudo chmod 777 -R /mnt/0/
sudo chmod 777 -R /mnt/__tmp/

# görmek için
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY KDE_SESSION_VERSION=5 KDE_FULL_SESSION=true dolphin


##################################

sudo mkdir -p /mnt/__tmp/erp/
git clone https://github.com/Mustafaozver/erp.git /mnt/0/erp/


sudo mkdir -p /mnt/__tmp/grub_bios_theme/
sudo mkdir -p /mnt/boot/grub/themes/
git clone https://github.com/Mustafaozver/my_linux_grub_theme.git /mnt/__tmp/grub_bios_theme/
sudo cp -R /mnt/__tmp/grub_bios_theme/* /mnt/boot/grub/themes/






sudo mkdir -p /mnt/__tmp/grub-btrfs/
git clone https://github.com/Antynea/grub-btrfs.git /mnt/__tmp/

##################################

sudo mkdir -p /mnt/__tmp/debs/

sudo wget -O /mnt/__tmp/debs/google-chrome-stable.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo wget -O /mnt/__tmp/debs/bitwarden.deb https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb
```

## Uygulama Repoları : sources.list

[[CLİNUX/sources.list|sources.list]]
,

```bash
sudo nano /mnt/etc/apt/sources.list
```

```read
deb http://archive.ubuntu.com/ubuntu/ noble universe restricted main multiverse  
deb http://security.ubuntu.com/ubuntu/ noble-security universe restricted main multiverse  
deb http://archive.ubuntu.com/ubuntu/ noble-updates universe restricted main multiverse
```

```bash
sudo chroot /mnt apt update
sudo chroot /mnt apt upgrade -y
sudo chroot /mnt apt dist-upgrade -y

sudo apt install bookworm-backports -y
```

## Yerel Ağ Tanımlamaları : resolv.conf

[[CLİNUX/resolv.conf|resolv.conf]]
,

```bash
sudo nano /mnt/etc/resolv.conf
```

```read
nameserver 127.0.0.53
options edns0 trust-ad
search home
```

## Yerelleştirme (Türkçe, Türkiye)

[[CLİNUX/Yerelleştirme|Yerelleştirme]]
,

```bash
sudo rm /mnt/etc/localtime
sudo ln -sf /mnt/usr/share/zoneinfo/Europe/Istanbul /mnt/etc/localtime


sudo nano /mnt/etc/locale.gen
```

```read
en_US.UTF-8 UTF-8
tr_TR.UTF-8 UTF-8
```

```bash
sudo nano /mnt/etc/locale.conf
```

```read
LANG=tr_TR.UTF-8
```

```bash
sudo nano /mnt/etc/vconsole.conf
```

```read
KEYMAP=trq
```

---

```bash
sudo chroot /mnt apt install locales -y
sudo chroot /mnt dpkg-reconfigure tzdata
sudo chroot /mnt dpkg-reconfigure locales
sudo chroot /mnt locale-gen
```

## Kernel Çekirdeği

[[CLİNUX/Kernel Yükle|Kernel Yükle]]
[XanMod Kernel](https://xanmod.org/)
,

```bash
sudo chroot /mnt apt update
sudo chroot /mnt apt install linux-image-generic -y
#sudo chroot /mnt apt install linux-headers-generic -y
#sudo chroot /mnt apt install linux-tools-generic -y

## Diğer library ler

sudo chroot /mnt dpkg -i /linux-image-zenmod.deb

sudo chroot /mnt apt install sudo dhcpcd5 -y

sudo chroot /mnt apt install linux-image-amd64 -y
sudo chroot /mnt apt install linux-headers-amd64 -y
sudo chroot /mnt apt install console-setup ntp -y
sudo chroot /mnt apt install plymouth-themes -y





sudo chroot /mnt apt install grub-efi-amd64 -y
sudo chroot /mnt apt install btrfs-progs -y
sudo chroot /mnt apt install btrfs-tools -y
sudo chroot /mnt apt install cryptsetup -y
sudo chroot /mnt apt install lvm2 -y
sudo chroot /mnt apt install exfatprogs -y
sudo chroot /mnt apt install exfat-utils -y
sudo chroot /mnt apt install exfat-fuse -y



# sudo chroot /mnt apt install zfsutils-linux -y
# sudo chroot /mnt apt install zfs-initramfs -y
# sudo chroot /mnt apt install zfs-dkms -y

sudo chroot /mnt apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget -y

sudo chroot /mnt apt install git dosfstools amd64-microcode nano -y






sudo chroot /mnt apt install dosfstools amd64-microcode network-manager git cryptsetup lvm2 sudo -y

sudo chroot /mnt apt install lsb-release ca-certificates apt-transport-https software-properties-common -y

sudo chroot /mnt apt install cups printer-driver-all system-config-printer simple-scan xsane -y






sudo chroot /mnt apt install tzdata curl ca-certificates openssh-server curl -y

sudo chroot /mnt apt install sensors-applet -y

sudo chroot /mnt apt install psensor fancontrol -y

sudo chroot /mnt apt install tlp ubuntu-restricted-extras -y

sudo chroot /mnt apt install ufw -y




sudo chroot /mnt apt install hibernate -y
sudo chroot /mnt apt install pm-utils -y
sudo chroot /mnt apt install polkitd-pkla -y


## nvidia sürücüleri
sudo ubuntu-drivers install
sudo ubuntu-drivers install --gpgpu

## TLP-UI Kur
## sudo chroot /mnt apt install tlp -y
## sudo nano /mnt/etc/tlp.conf

## Bleachbit
## Ananicy-cpp

sudo chroot /mnt apt install plymouth-theme-breeze kde-config-plymouth -y

sudo chroot /mnt update-alternatives --config default.plymouth


sudo chroot /mnt ubuntu-drivers autoinstall

sudo chroot /mnt apt --fix-missing update
sudo chroot /mnt apt --fix-broken install -y
sudo chroot /mnt apt autoremove
sudo chroot /mnt apt clean
sudo chroot /mnt update-initramfs -u -k all


```

## Diskleri Sisteme Tanıtılması

[[CLİNUX/Disklerin Tanıtılması|Disklerin Tanıtılması]]
,

```bash
sudo su # dosyaya yazma sırasında sudo lazım
sudo genfstab -U /mnt >> /mnt/etc/fstab

sudo nano /mnt/etc/fstab

```

Eklenecek :

```read
tmpfs /tmp tmpfs rw,nosuid,nodev,inode64 0 0
```

## Bootloader : GRUB

[[CLİNUX/Bootloader|Bootloader]]
[[CLİNUX/Grub BTRFS|Grub BTRFS]]
[[CLİNUX/AYARLAR/Hibernate|Hibernate]]
,

```bash
sudo chroot /mnt apt install grub-efi-amd64 -y
sudo chroot /mnt update-initramfs -u -k all
sudo chroot /mnt update-grub
sudo grub-install /dev/nvme0n1
sudo chroot /mnt grub-install
```

```bash
sudo nano /mnt/etc/default/grub
```

```read
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
GRUB_TIMEOUT_STYLE=menu
GRUB_TIMEOUT=10
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=UUID=5363fe72-4bd7-4601-98bf-05c6a5ee819d"
GRUB_CMDLINE_LINUX=""
#GRUB_CMDLINE_LINUX="cryptdevice=UUID=<UUID-sda4>:root root=/dev/mapper/ROOT-root rootflags=subvol=@"

#GRUB_PRELOAD_MODULES=lvm

#GRUB_DISABLE_OS_PROBER=false
#GRUB_GFXMODE=640x480

GRUB_THEME="/boot/grub/themes/theme_1/theme.txt"
```

```bash
sudo nano /boot/grub/grub.cfg
```

```bash
sudo chroot /mnt update-grub
sudo chroot /mnt systemctl hibernate
```

## Kullanıcılar

[[CLİNUX/Kullanıcılar|Kullanıcılar]]
,

```bash
## useradd -mG wheel mustafa
sudo chroot /mnt useradd -mG sudo mustafa
sudo chroot /mnt useradd -mG sudo admin
sudo chroot /mnt useradd sandbox
sudo chroot /mnt useradd sshuser

sudo chroot /mnt passwd

sudo chroot /mnt passwd admin
sudo chroot /mnt passwd mustafa
sudo chroot /mnt passwd sandbox
sudo chroot /mnt passwd sshuser

# samba kullanıcısı

sudo chroot /mnt apt install samba -y
sudo chroot /mnt useradd samba
sudo chroot /mnt smbpasswd -a samba
```

```bash
sudo nano /mnt/etc/sudoers
```

```read
admin ALL=(ALL)ALL, !SHELLS, !SU
mustafa ALL=(ALL:ALL) NOPASSWD: ALL
sandbox ALL=(ALL:ALL) ALL,!ALL
sshuser ALL=(ALL) NOPASSWD: ALL
```

```bash
sudo mkdir -p /mnt/home/mustafa
sudo mkdir -p /mnt/home/samba

sudo mkdir -p /mnt/home/mustafa/Templates
sudo mkdir -p /mnt/home/mustafa/Public
sudo mkdir -p /mnt/home/mustafa/Videos
sudo mkdir -p /mnt/home/mustafa/Music
sudo mkdir -p /mnt/home/mustafa/Pictures
sudo mkdir -p /mnt/home/mustafa/Documents
sudo mkdir -p /mnt/home/mustafa/Desktop
sudo mkdir -p /mnt/home/mustafa/Downloads

sudo mkdir -p /mnt/home/mustafa/.config
sudo mkdir -p /mnt/home/mustafa/.icons
sudo mkdir -p /mnt/home/mustafa/.local

sudo mkdir -p /mnt/home/mustafa/.config/bspwm
sudo mkdir -p /mnt/home/mustafa/.config/sxhkd

sudo chmod 777 -R /mnt/home/mustafa/

sudo chmod 777 -R /mnt/home/samba/

sudo mkdir -p /mnt/0/
sudo chmod 777 -R /mnt/0/

```

## Desktop Environment : KDE Plasma

[[CLİNUX/DE Yükleme|DE Yükleme]]
,

```bash
sudo chroot /mnt apt install kde-full -y # sadece x11
sudo chroot /mnt apt install plasma-workspace-wayland -y

sudo chroot /mnt apt install kubuntu-desktop -y
sudo chroot /mnt apt install plasma-desktop -y

sudo chroot /mnt apt install qt5-style-kvantum qt5-style-kvantum-themes -y

sudo chroot /mnt apt install kwin-bismuth -y
sudo chroot /mnt apt install ultracopier -y
# sudo chroot /mnt apt install wlr-randr -y
sudo chroot /mnt apt install kio-admin -y

sudo chroot /mnt dpkg-reconfigure sddm


sudo chroot /mnt apt install samba samba-client samba-common -y

```

## Kişisel Configurasyonlarım

```bash
sudo mkdir -p /mnt/home/admin/__tmp/
sudo chmod 777 /mnt/home/admin/__tmp/
git clone https://github.com/Mustafaozver/linux_ubuntu_mantic_overwrite.git /mnt/home/admin/__tmp/

## sudo su
sudo sh /mnt/home/admin/__tmp/install.sh

##

sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/lilith-glamour/lilith-glamour.plymouth 100

sudo update-alternatives --config default.plymouth

sudo update-initramfs -u -k all

##

```

## Gerekli Uygulamalar

[[CLİNUX/Gerekli Programlar|Gerekli Programlar]]
,

```bash
sudo chroot /mnt apt install synaptic -y
sudo chroot /mnt apt install flatpak -y
sudo chroot /mnt apt install nala -y
sudo chroot /mnt apt install libreoffice -y
sudo chroot /mnt apt install wget gpd nano -y

sudo chroot /mnt apt install htop -y
sudo chroot /mnt apt install git -y
sudo chroot /mnt apt install neofetch -y
sudo chroot /mnt apt install zsh -y
sudo chroot /mnt apt install guake -y

sudo chroot /mnt apt install veracrypt -y
sudo chroot /mnt apt install thunderbird -y
sudo chroot /mnt apt install libreoffice -y
sudo chroot /mnt apt install distrobox -y
sudo chroot /mnt apt install podman -y

sudo chroot /mnt nala install firefox
sudo chroot /mnt apt install chromium-browser -y
sudo chroot /mnt apt install opera-stable -y

flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo

sudo chroot /mnt dpkg --add-architecture i386
sudo chroot /mnt apt update
sudo chroot /mnt apt install wine -y
sudo chroot /mnt apt install libwine -y
sudo chroot /mnt apt install fonts-wine -y
sudo chroot /mnt apt install wine32 -y
sudo chroot /mnt apt install wine64 -y

sudo chroot /mnt apt update
sudo chroot /mnt apt --fix-missing update
sudo chroot /mnt apt --fix-broken install
sudo chroot /mnt apt autoremove
sudo chroot /mnt apt clean




sudo chroot /mnt apt install curl apt-transport-https -y
sudo chroot /mnt apt install thunderbird -y
sudo chroot /mnt apt install timeshift -y
sudo chroot /mnt apt install syncthing -y
sudo chroot /mnt apt install openssh-server openssh-client -y
sudo chroot /mnt apt install stacer -y
sudo chroot /mnt apt install flatpak -y




sudo chroot /mnt apt install nodejs npm -y
sudo chroot /mnt apt install postgresql postgresql-contrib -y
sudo chroot /mnt apt install sqlite3 libsqlite3-dev -y

sudo chroot /mnt apt install redis -y

sudo chroot /mnt apt install rabbitmq-server -y
sudo chroot /mnt apt install elasticsearch -y


sudo chroot /mnt dpkg -i /__tmp/*


cd /mnt/__tmp/grub-btrfs
sudo make install

##

sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/lilith-glamour/lilith-glamour.plymouth 100

sudo update-alternatives --config default.plymouth

sudo update-initramfs -u -k all

## # # # # #

```

## Temizlik

[[CLİNUX/Temizlik|Temizlik]]
,

```bash
sudo chmod -R g-rwx,o-rwx /mnt/boot

sudo chroot /mnt update-initramfs -u -k all

sudo chroot /mnt systemctl enable dhcpcd

sudo chroot /mnt update-grub

sudo umount -lf -R /mnt/* 2>/dev/null

sudo rm -rf /mnt/__tmp/*

sudo chroot /mnt apt autoremove
sudo rm -f /mnt/root/.bash_history
sudo rm -rf /mnt/var/lib/apt/lists/*
find /mnt/var/log/ -type f | xargs rm -f

sudo swapoff --all


```

## Ek Ayarlar

### SDDM Auto Login

```bash
sudo mkdir -p /mnt/etc/sddm.conf.d/
sudo nano /mnt/etc/sddm.conf.d/autologin.conf
```

```read
[Autologin]
User=mustafa
Session=plasmawayland

[Theme]
Current=Infinity-SDDM
CursorTheme=Esinti_Dark_Neon
Font=Noto Sans,10,-1,0,50,0,0,0,0,0
  
[Users]
MaximumUid=60000
MinimumUid=1000

[General]
Numlock=on

[Users]
HideUsers=samba,ssh,admin

```

## Açılışta

```bash

sudo add-apt-repository ppa:alessandro-strada/ppa
sudo apt-get install google-drive-ocamlfuse
mkdir ~/migoogledrive
google-drive-ocamlfuse ~/migoogledrive



curl -s https://syncthing.net/release-key.txt | sudo apt-key add -

echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

sudo apt install syncthing -y

sudo apt install wireshark -y




sudo snap install obsidian --classic
sudo snap install muezzin
sudo snap install firefox
sudo snap install bitwarden
sudo snap install sqlitebrowser

sudo systemctl enable syncthing@username.service
sudo systemctl enable ssh

git config --global user.name "Mustafaozver"
git config --global user.email "mustafa.ozver@hotmail.com"
git config --global credential.credentialStore plaintext





sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
sudo apt update

sudo apt install fonts-firacode -y


# Yedekle
sudo timeshift --create --comments "ROOT BACKUP" --tags D

# Yedekleri Listele
sudo timeshift --list

# Yedekten Geri Yükle
sudo timeshift --restore


sudo reboot
```

---

## EKLER :

.

```bash

sudo mount -t btrfs -o noatime,compress=lzo,space_cache=v2,subvol=@ /dev/nvme0n1p4 /mnt
sudo mount /dev/nvme0n1p5 /mnt/home
sudo mount /dev/nvme0n1p2 /mnt/boot
sudo mount /dev/nvme0n1p1 /mnt/boot/efi

# Yedekle
sudo timeshift --create --comments "ROOT BACKUP" --tags D

# Yedekleri Listele
sudo timeshift --list

# Yedekten Geri Yükle
sudo timeshift --restore



```