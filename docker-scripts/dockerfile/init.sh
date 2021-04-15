#!/bin/bash

echo "ActiveMQ的IP：$1***********"
echo "ActiveMQ的端口号：$2***********"
echo "Geoserver的角色名：$3***********"

PROPERTIES_FILE=/usr/local/geoserver-2.16.2/data_dir/cluster/cluster.properties
readonly PROPERTIES_FILE
echo $PROPERTIES_FILE

sed -i '/brokerURL/d' $PROPERTIES_FILE
echo "brokerURL=nio\://$1\:$2" >> ${PROPERTIES_FILE}

LINE_NUM=$(grep -n instanceName ${PROPERTIES_FILE} | cut -d : -f 1)
INSTANCE_NAME=$(sed -n "${LINE_NUM}p" ${PROPERTIES_FILE} | cut -d = -f 2)
echo "实例名称为：$INSTANCE_NAME"

if [ "$INSTANCE_NAME" = "*" ]
then
  sed -i '/instanceName/d'  $PROPERTIES_FILE
  UUID=$(cat /proc/sys/kernel/random/uuid)
  echo $UUID
  echo "instanceName=$UUID" >> $PROPERTIES_FILE
fi

if [ "$3" == "master" ]
then
    echo "****************Master主节点配置开始***********************"
    sed -i '/toggleMaster/d'  $PROPERTIES_FILE
    echo "toggleMaster=true" >> $PROPERTIES_FILE

    sed -i '/toggleSlave/d'  $PROPERTIES_FILE
    echo "toggleSlave=false" >> $PROPERTIES_FILE
elif [ "$3" == "slave" ]
then
    echo "****************Slave从节点配置开始************************"
    sed -i '/toggleMaster/d'  $PROPERTIES_FILE
    echo "toggleMaster=false" >> $PROPERTIES_FILE

    sed -i '/toggleSlave/d'  $PROPERTIES_FILE
    echo "toggleSlave=true" >> $PROPERTIES_FILE
elif [ "$3" == "master_slave" ]
then
    echo "****************主从节点配置开始************************"
    sed -i '/toggleMaster/d'  $PROPERTIES_FILE
    echo "toggleMaster=true" >> $PROPERTIES_FILE

    sed -i '/toggleSlave/d'  $PROPERTIES_FILE
    echo "toggleSlave=true" >> $PROPERTIES_FILE
fi

sh /usr/local/geoserver-2.16.2/bin/startup.sh