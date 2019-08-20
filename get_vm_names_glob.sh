#!/bin/bash
# in our openstack we have only 4 compute nodes so, 
# we ssh in each of them and run get_vm_names.sh script
# with or without -i option

for i in $(seq 0 3);
  do
    echo -n "==nova-compute/";
    if [ -n "$1" ] && [ "$1" == "-i" ];
      then
        echo $i==; juju ssh nova-compute/$i sudo /home/ubuntu/get_vm_names.sh -i;
      else
        echo $i==; juju ssh nova-compute/$i sudo /home/ubuntu/get_vm_names.sh;
    fi
done;
