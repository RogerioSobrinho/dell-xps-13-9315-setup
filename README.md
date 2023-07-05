# archlinux-setup


```console
    _             _     
   / \   _ __ ___| |__  
  / _ \ | '__/ __| '_ \ 
 / ___ \| | | (__| | | |
/_/   \_\_|  \___|_| |_|
                        
__        __         _        _        _   _             
\ \      / /__  _ __| | _____| |_ __ _| |_(_) ___  _ __  
 \ \ /\ / / _ \| '__| |/ / __| __/ _` | __| |/ _ \| '_ \ 
  \ V  V / (_) | |  |   <\__ \ || (_| | |_| | (_) | | | |
   \_/\_/ \___/|_|  |_|\_\___/\__\__,_|\__|_|\___/|_| |_|
                                                         
 ____       _               
/ ___|  ___| |_ _   _ _ __  
\___ \ / _ \ __| | | | '_ \ 
 ___) |  __/ |_| |_| | |_) |
|____/ \___|\__|\__,_| .__/ 
                     |_|  
```

It is a simple Bash script developed to Arch linux post installation

Currently these scripts are for me but maybe they are useful for you too.

You can test it in a virtual machine (strongly recommended) like [VirtualBox](https://www.virtualbox.org/) before run it in real hardware.

### Step by step
#### Install
This is my fork of [Arch-Setup-Script](https://github.com/tommytran732/Arch-Setup-Script)

Changes to the original project:

- EXT4
- SWAP
- Systemd-boot
- Xorge as Rootless
- Luks2

### Run the command below to start the script install:

##### Obs: Check script before run

```bash
$ bash <(curl -s https://raw.githubusercontent.com/rogeriosobrinho/arch-workstation-setup/master/install.sh)
```

#### Post Install
- Enable Flatpak
- Enable AUR
- Install essentials apps - [packages.conf](https://github.com/RogerioSobrinho/arch-workstation-setup/blob/master/packages.conf)
- Enable Nvidia (proprietary driver)
- Apply monitor settings
- Git config - [.gitconfig](https://github.com/RogerioSobrinho/arch-workstation-setup/blob/master/dotfiles/.gitconfig)
- Install Docker + Docker compose
- Enable Bluetooth
- Enable OpenVPN
- Enable CUPS
- Enable [ASDF](https://asdf-vm.com/)
- Remove unnecessary shortcuts

### Run the command below to start the script post install:

```bash
$ git clone https://github.com/rogeriosobrinho/arch-workstation-setup.git
$ cd arch-workstation-setup
$ chmod +x post_install.sh
$ ./post_install.sh
```

