#!/bin/bash

#for each instance which has a running state
#  example:
#    instance-00000055
#    instance-00000031

for i in $(virsh list | grep running | awk '{ print $2 }');
  do
    #print intance id name
    echo -n $i;
    echo -n ": ";

    #print name of the vm
    #  example:
    #    $ virsh dumpxml instance-00000055 | grep ":name" | cut -d\> -f2 | cut -d\< -f1;
    #    Zabbix

    virsh dumpxml $i | grep ":name" | cut -d\> -f2 | cut -d\< -f1;

    #IF '-i' option is enabled:

    if [ -n "$1" ] && [ "$1" == "-i" ]; then

      #for each tap interface attached to VM :
      #  example:
      #    virsh dumpxml instance-00000055 | grep "target dev='tap" | cut -d\' -f2 | cut -d\' -f1
      #    tap3dd4f12a-c8

      for j in $(virsh dumpxml $i | grep "target dev='tap" | cut -d\' -f2 | cut -d\' -f1);
        do
          #get ovs vlan tag for this interface
          #  example:
          #    sudo ovs-vsctl show   | grep "Port \"...3dd4f12a-c8\"" -A 1 | grep "tag" | awk '{ print $2 }'
          #    4

	  ovs_vlan_tag=$(sudo ovs-vsctl show   | grep "Port \"...${j:3}\"" -A 1 | grep "tag" | awk '{ print $2 }');

	  #create a string from this tag:
	  #  example:
          #    "actions=mod_vlan_vid:4,"

	  ovs_vlan_tag_to_grep="actions=mod_vlan_vid:$ovs_vlan_tag,";

          #grep openflow flow from the OVS by this string:
          #  example:
          #    sudo ovs-ofctl dump-flows br-int | grep "actions=mod_vlan_vid:4,"
          #    "cookie=0x8ada0fcae237a787, duration=5206669.808s, table=0, n_packets=39178631, n_bytes=36700425686, priority=3,in_port="int-br-data",dl_vlan=1200 actions=mod_vlan_vid:4,resubmit(,60)"

	  ovs_flow=$(sudo ovs-ofctl dump-flows br-int | grep $ovs_vlan_tag_to_grep);

          #IF result is not empty the extract physical vlan and print
	  #ELSE it may not be vlan (gre,vxlan ?)

	  if [ -n "$ovs_flow" ];
            then
	      vlan=$(echo $ovs_flow | grep -o -E "dl_vlan=[0-9]+" | grep -o -E "[0-9]+");
              echo "  vlan=$vlan";
            else
              echo "  !!! not a vlan ?!";
          fi

      done;
    fi
done;
