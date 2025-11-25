

#!/usr/bin/env bash


CONFIG_FILE="config.conf"



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
  
  if [[ ! -f "$CONFIG_FILE" ]] ; then
    echo "file not found"
    exit 1
  fi

  source "./$CONFIG_FILE"

}



function setup(){

  echo " You are configuring and installing the vm for the iso $1"
  
  iso=$(basename $1)
  dirname="${iso%%-*}"
  upper="${dirname^^}"
  echo "This will create a dir with name $upper". Its ok?
  
  mkdir "$upper"
  cp $1 $upper
  cp $CONFIG_FILE $upper
  cd $upper
  echo " Do you wanna use the default paramater or do you wanna set disk and ram space?  "
  echo " 1) select default parameters from config file"
  echo " 2) set paramaters"
  read -p "[?] ->" CHOICE 

  if [[ "$CHOICE" == 1 ]]; then
    check_config_file
  else
    read -p "[?] set ram amount" RAM_SPACE
    read -p "[?] set disk amount" DISK_SPACE
  fi
  echo "ram: $RAM_SPACE , disk: $DISK_SPACE" 
  
}

function create_disk(){
  
  read -p "[] insert the name for disk image: " DISK_NAME
  qemu-img create -f qcow2 $DISK_NAME $DISK_SPACE
}

function install_distro(){
  echo ""
  read -p "[] installing distro"
  qemu-system-x86_64 -m $RAM_SPACE -smp 1 -enable-kvm -nic user,model=virtio-net-pci -boot menu=on,order=d -drive file=$DISK_NAME   -drive media=cdrom,file=$iso -display gtk

  VM_DIR="$HOME/VMs/$upper"

  cat <<EOF > "$VM_DIR/run.sh"
#!/usr/bin/env bash

qemu-system-x86_64 \
-enable-kvm \
-cpu host \
-smp 2 \
-m $RAM_SPACE \
-drive file=$DISK_NAME ,format=qcow2,if=virtio \
-nic user,model=virtio-net-pci \
-display gtk
EOF

  chmod +x "$VM_DIR/run.sh"

}


function setup_vm(){
  init
  setup $1
  create_disk
  install_distro


}



function start_distro(){
  echo "do nothing for now"
}




setup_vm $1
