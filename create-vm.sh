#!/bin/bash 

set -ex

source ./vm_env

purge_old_object(){

 rm -rf $WORKSPACE/$HOSTNAME

}

generate_data(){

 IMAGE=$TEMPLATE/CentOS-7-x86_64-GenericCloud-2003.qcow2

 mkdir -p $WORKSPACE/$HOSTNAME
 cp $IMAGE $WORKSPACE/$HOSTNAME/$HOSTNAME.qcow2
 cp $TEMPLATE/user-data $WORKSPACE/$HOSTNAME/$USER_DATA
 cat template/meta-data | sed -e "s/HOSTNAME/$HOSTNAME/g" -e "s/ADDRESS/$ADDRESS/g" > $WORKSPACE/$HOSTNAME/$META_DATA

}

generate_ciimage(){

 genisoimage -output $WORKSPACE/$HOSTNAME/$CI_ISO -volid cidata -joliet -r $WORKSPACE/$HOSTNAME/$USER_DATA $WORKSPACE/$HOSTNAME/$META_DATA &>> $WORKSPACE/$HOSTNAME/$HOSTNAME-gen-image.log

}

create_vm() {

 virt-install \
  --memory $MEM \
  --vcpus $CPU \
  --name ${HOSTNAME} \
  --disk $WORKSPACE/$HOSTNAME/$HOSTNAME.qcow2,device=disk \
  --disk $WORKSPACE/$HOSTNAME/$CI_ISO,device=cdrom \
  --os-type Linux \
  --os-variant centos7.0 \
  --virt-type kvm \
  --graphics none \
  --network bridge=br0

}

purge_old_object
generate_data
generate_ciimage
create_vm

