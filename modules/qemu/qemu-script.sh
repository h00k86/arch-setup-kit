

#!/usr/bin/env bash


CONFIG_FILE="./config.conf"



function init(){

  clear
  echo " ================================================================"
  echo " ===----------------------------------------------------------==="
  echo " ===---                                                    ---==="
  echo " ===---  QEMU Utilities. Install and start VM's            ---==="
  echo " ===---                                                    ---==="
  echo " ===----------------------------------------------------------==="
  echo " ================================================================"
  echo
  echo
}



function check_config_file(){
  
  if [[ ! -f "$CONFIG_FILE"]] ;; then
    echo "file not found"
    exit 1
  fi

  source "$CONFIG_FILE"

}



function setup(){

  # create dir e copy necessary files
  echo "[] create VMs dir"
  mkdir -p $HOME/VMs
  cp $0 $HOME/VMs
  cp $CONFIG_FILE $HOME/VMs

  echo "DO you wanna use the default paramater or do you wanna set disk and ram space?  "
  echo "1) select default parameters from config file"
  echo "2) set paramaters"
  read -p "[?] ->" CHOICE 

  if [[ "$CHOISE" == 1 ]]; then
    check_config_file
  else
    read -p "[?] set ram amount" RAM_SPACE
    read -p "[?] set disk amount" DISK_SPACE
  fi
  echo "ram: $RAM_SPACE , disk: $DISK_SPACE" 
  
}

function create_disk(){
  
  read -p "[] insert the name for disk image" DISK_NAME
  qemu-img create -f qcow2 $DISK_NAME $DISK_SPACE
}

function install_distro(){
  echo ""
  read -p "[] insert the name of iso distro " DISTRO_ISO
  qemu-system-x86_64 -m $RAM -smp 1 -enable-kvm -nic user,model=virtio-net-pci -boot menu=on,order=d -drive file=$DISK_NAME   -drive media=cdrom,file=$DISTRO_ISO

}


function setup_vm(){
  init
  check_config_file
  create_disk
  install_distro


}



function start_distro(){
  echo "do nothing for now"
}






setup
