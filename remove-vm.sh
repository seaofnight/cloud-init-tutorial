#!/bin/bash 

VM_NAME=kf0

virsh shutdown $VM_NAME 
sleep 1
virsh undefine $VM_NAME --remove-all-storage 
rm -rf $VM_NAME
