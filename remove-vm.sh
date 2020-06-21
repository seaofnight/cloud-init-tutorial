#!/bin/bash 

source ./vm_env 

virsh shutdown $HOSTNAME
sleep 1
virsh undefine $HOSTNAME --remove-all-storage 
rm -rf $HOSTNAME

ls -al ./
