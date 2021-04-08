#!/bin/sh
#1.	声明变量，保存用户执行位置（变量名大写，单词以“_”分割e.g USER_PATH）
USER_PATH=${PWD}
BASH_PROFILE="/etc/profile"
PROGRAM_NAME="tong-gsm-boot-1.0.0-snapshot.jar"
PROGRAM_PID="app.pid"
PROGRAM_PATH="bin/${PROGRAM_NAME}"
PROFILE_PATH="conf"
COUNT=
#JVM参数
JVM_OPTS="-Dname=$PROGRAM_PATH -Duser.timezone=Asia/Shanghai -Xms512M -Xmx1024M -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m -XX:+HeapDumpOnOutOfMemoryError -XX:+PrintGCDateStamps  -XX:+PrintGCDetails -XX:NewRatio=1 -XX:SurvivorRatio=30 -XX:+UseParallelGC -XX:+UseParallelOldGC"


#2.	查找脚本存在位置（后续启动按脚本相对路径启动）
SHELL_DIR="$( cd "$( dirname "$BASH_SOURCE"  )" && pwd  )"
#echo "The shell path is "${SHELL_DIR}

#3.	声明系统环境变量
source ${BASH_PROFILE}
#4.	声明程序自己环境变量,cd 到程序目录
cd ${SHELL_DIR}
export INSTALL_DIR=${SHELL_DIR}



#5.	检查是否已存在程序进程，如果已启动，则退出脚本
COUNT=`ps -A | grep ${PROGRAM_NAME} | awk -F' ' '{if($4=="'"${PROGRAM_NAME}"'") print $1}' | wc -l`
if [ ${COUNT} -ge 1 ]; then
	echo "the proxy is process on already num is ${COUNT}"
	#7.	＃程序后台运行，并把运行pid写入app.pid文件中
	cd ${USER_PATH}
	if [ "$0" = "-bash"  -o "$0" = "bash" ]; then
		echo "use source"
		return
	else
		echo "use sh"
		exit
	fi
fi

#6.	＃程序后台运行，并把运行pid写入app.pid文件中
nohup java $JVM_OPTS -jar $PROGRAM_PATH --spring.config.location=./conf/application-test.yaml,./conf/application.properties >/dev/null 2>&1 &
echo $!>${PROGRAM_PID}

#7.	＃程序后台运行，并把运行pid写入app.pid文件中
cd ${USER_PATH}