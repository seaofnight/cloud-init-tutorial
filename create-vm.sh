#!/bin/bash 

WORKSPACE=${PWD}
TEMPLATE=$WORKSPACE/template

CPU=6
MEM=10240
HOSTNAME=kf0
DISK=$HOSTNAME.qcow2

USER_DATA=user-data
META_DATA=meta-data
CI_ISO=$HOSTNAME-cidata.iso

IMAGE=$TEMPLATE/CentOS-7-x86_64-GenericCloud-2003.qcow2

rm -rf $WORKSPACE/$HOSTNAME 
mkdir -p $WORKSPACE/$HOSTNAME
cp $IMAGE $WORKSPACE/$HOSTNAME/$HOSTNAME.qcow2

cp $TEMPLATE/user-data $WORKSPACE/$HOSTNAME/$USER_DATA
cp $TEMPLATE/meta-data $WORKSPACE/$HOSTNAME/$META_DATA

genisoimage -output $WORKSPACE/$HOSTNAME/$CI_ISO -volid cidata -joliet -r $WORKSPACE/$HOSTNAME/$USER_DATA $WORKSPACE/$HOSTNAME/$META_DATA &>> $WORKSPACE/$HOSTNAME/$HOSTNAME-gen-image.log

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
  --network bridge=br0 \
  --import

