#!/bin/bash

if [ ! -f "./.env" ]; then
	echo "No file named .env in current directory : $(pwd)"
	exit 1
fi

source ./.env

if [ ! -f $TEMPLATES ]; then
	echo "No file named pve_template.txt in current directory : $(pwd)"
	exit 1
fi

while IFS= read -r line; do

	# TODO Add format verification 

    echo "Template input : $line"
    # DISK=
    ID="$(awk -F  '#' '{print $1}' <<< $line )"
	NAME="$(awk -F  '#' '{print $2}' <<< $line )"
	ISO_PATH="$(awk -F  '#' '{print $3}' <<< $line )"
	NET="$(awk -F  '#' '{print $4}' <<< $line )"
	STORAGE="$(awk -F  '#' '{print $5}' <<< $line )"

	CPU="${ID:1:2}"
	MEM="${ID:3:2}"
	MEM_NUM=$((10#$MEM))
    MEM=$(($MEM_NUM * 1024))
	SSD="${ID:5:4}G"

	echo "Creating Cloud-Init Template with following values : "
	echo "  --Name $NAME"
	echo "  --Core $CPU"
	echo "  --Memory $MEM"
	echo "  --Storage $SSD"
	echo "  --Img $ISO_PATH"

	# -f Check ISO_PATH

	# TODO Add verification return code $?==0 for each command

	qm create $ID --memory $MEM --core $CPU --name $NAME --net0 $NET
	# need to fetch last line of return
	IMPORT_DISK_OUTPUT="$(qm importdisk $ID $ISO_PATH $STORAGE | tail -n1)"
	# for scsi name
	DISK="$(awk -F  'unused0:' '{print $2}' <<< $IMPORT_DISK_OUTPUT )"
	# minus last quote
	SCSI_NAME="${DISK:0:-1}"
	qm set $ID --scsihw virtio-scsi-pci --scsi0 $SCSI_NAME,ssd=1
	qm disk resize $ID scsi0 $SSD
	qm set $ID --ide2 $STORAGE:cloudinit
	qm set $ID --boot c --bootdisk scsi0
	qm set $ID --serial0 socket --vga serial0
	
	qm set $ID --ciuser $CIUSER
	qm set $ID --sshkey $SSH_PATH
	qm set $ID --ipconfig0 ip=dhcp

	qm template $ID
	# else
	# qm destroy $ID

done < $TEMPLATES


# # TODO Add verification return code ==0 for each command
# qm create $ID --memory $MEM --core $CPU --name $NAME --net0 $NET
# 
# # need to fetch last line of return
# IMPORT_DISK_OUTPUT="$(qm importdisk $ID $ISO_PATH $STORAGE | tail -n1)"
# # for scsi name
# DISK="$(awk -F  'unused0:' '{print $2}' <<< $IMPORT_DISK_OUTPUT )"
# # minus last quote
# SCSI_NAME="${DISK:0:-1}"
# 
# qm set $ID --scsihw virtio-scsi-pci --scsi0 $SCSI_NAME,ssd=1
# qm disk resize $ID scsi0 $SSD
# qm set $ID --ide2 $STORAGE:cloudinit
# qm set $ID --boot c --bootdisk scsi0
# qm set $ID --serial0 socket --vga serial0
# 
# qm set $ID --ciuser $CIUSER
# qm set $ID --sshkey $SSH_PATH
# qm set $ID --ipconfig0 ip=dhcp
# 
# if $RC==0
# qm template $ID
# else
# qm destroy $ID
