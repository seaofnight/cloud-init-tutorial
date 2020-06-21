# cloud-init-tutorial

# 사전준비사항 

* KVM install 
* KVM Bridge Network 구성 

# KVM 배포 전 수정 항목 

* 현재는 1개의 vm 만 배포

```sh 

# cat vm_env 
CPU=6			# KVM 의 할당되는 CPU
MEM=10240		# KVM 할당 Memory
HOSTNAME=controller	# virsh instence name, Guest 에 사용되는 hostname
ADDRESS=192.168.14.174 # subnet,gateway 를 수정하는경우 template/meta-data 직접 수정 

```

# 실행 

```sh 
sh create-vm.sh
```
