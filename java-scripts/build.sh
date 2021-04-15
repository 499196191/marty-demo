#!/bin/sh
RESOURCE_NAME=geo/gsp


rm -rf $RESOURCE_NAME



mkdir -p $RESOURCE_NAME
mv tong-gsm-boot/target $RESOURCE_NAME



mkdir $RESOURCE_NAME/bin $RESOURCE_NAME/log $RESOURCE_NAME/doc $RESOURCE_NAME/lib $RESOURCE_NAME/module  $RESOURCE_NAME/driver $RESOURCE_NAME/example

cp $RESOURCE_NAME/target/tong-gsm-boot-1.0.0*.jar ./$RESOURCE_NAME/bin
mv $RESOURCE_NAME/target/conf $RESOURCE_NAME/
cp ./scripts/restart.sh ./$RESOURCE_NAME/
cp ./scripts/start.sh ./$RESOURCE_NAME/
cp ./scripts/stop.sh ./$RESOURCE_NAME/

rm -rf $RESOURCE_NAME/target/archive-tmp
rm -rf $RESOURCE_NAME/target/classes
rm -rf $RESOURCE_NAME/target/test-classes
rm -rf $RESOURCE_NAME/target/generated-test-sources
rm -rf $RESOURCE_NAME/target/generated-sources
rm -rf $RESOURCE_NAME/target/maven-archiver
rm -rf $RESOURCE_NAME/target/maven-status

rm -f $RESOURCE_NAME/target/tong-gsm-boot-1.0.0*.jar

rm -f $RESOURCE_NAME/target/tong-gsm-boot-1.0.0*.jar.original


tar -zcvf tong-gsm-boot-1.0.0.tar.gz $RESOURCE_NAME
echo "finish tar"
