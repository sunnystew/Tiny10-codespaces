echo "Installing packages..."
sudo apt update
sudo apt install qemu-kvm virtinst libvirt-clients bridge-utils libvirt-daemon-system tigervnc-standalone-server dwm aqemu -y > installlogs.txt
echo "Packages installed."
echo "Now downloading NoVNC..."
sudo git clone https://github.com/novnc/noVNC
echo "NoVNC downloaded."
sudo mkdir /root/.aqemu
cd ~
mkdir tiny10
cd tiny10
sudo qemu-img create hdd.img 26G
sudo wget https://github.com/L36D/Tiny10/releases/download/v1/Tiny10.iso
echo "Virtual HDD with size of 26 GB made. Tiny10 ISO downloaded."
qemu-system-x86_64 --enable-kvm -m 3G -smp 2 -pflash /usr/share/OVMF/OVMF_CODE.fd --hdd hdd.img --cdrom Tiny10.iso
echo "VM started. Now running VNC server..."
sudo vncserver -SecurityType None -xstartup "dwm" -rfbport 5900 && sudo /noVNC/utils/novnc_proxy --vnc 127.0.0.1:5900 --listen localhost:6080
echo "VNC server is running."
echo "Please start the installation of Windows."
