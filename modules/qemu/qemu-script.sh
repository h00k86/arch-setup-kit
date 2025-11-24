

#!/usr/bin/env bash


CONFIG_FILE="./config.conf"



function check_config_file(){
  
  if [[ ! -f "$CONFIG_FILE"]] ;; then
    echo "file not found"
    exit 1
  fi

  source "$CONFIG_FILE"

}




function create_disk(){
  
  clear  
  read -p "[] insert the name for disk image" DISK_NAME
  qemu-img create -f qcow2 $DISK_NAME $DISK_SPACE
}

function install_distro(){
  echo ""
  read -p "[] insert the name of iso distro " DISTRO_ISO
  qemu-system-x86_64 -m $RAM -smp 1 -enable-kvm -nic user,model=virtio-net-pci -boot menu=on,order=d -drive file=$DISK_NAME   -drive media=cdrom,file=$DISTRO_ISO

}


function setup_vm(){

  check_config_file
  create_disk
  install_distro


}



function start_distro(){
  echo "do nothing for now"
}
