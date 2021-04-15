
#1.	声明变量，保存用户执行位置（变量名大写，单词以“_”分割e.g USER_PATH）
USER_PATH=${PWD}
PROGRAM_NAME="tong-gsm-boot-1.0.0-snapshot.jar"
PROGRAM_PID="app.pid"
SHELL_DIR=
INSTALL_DIR=
COUNT=

#2.	查找脚本存在位置（后续启动按脚本相对路径启动）
SHELL_DIR="$( cd "$( dirname "$BASH_SOURCE"  )" && pwd  )"
#echo "The shell path is "${SHELL_DIR}
INSTALL_DIR=${SHELL_DIR}

#3.	cd 到程序目录,读取app.pid中pid
cd ${INSTALL_DIR}
PROGRAME_PID=$(cat ${PROGRAM_PID})
echo "The programpid is ${PROGRAME_PID}"

#4.	判断读取pid是否为数字，若为空或不是数字则通过ps 命令获取进程号
expr $PROGRAME_PID + 0 &>/dev/null
if [ $? -ne 0 ]; then
	echo "reget programpid is ${PROGRAME_PID}"
	PROGRAME_PID=`ps -A | grep ${PROGRAM_NAME} | awk -F' ' '{if($4=="'"${PROGRAM_NAME}"'") print $1}'`
fi

#5.	杀死进程
kill  ${PROGRAME_PID}

#6.	等待
sleep 1

#7.	监测进程是否还在
COUNT=`ps -A | grep ${PROGRAM_NAME} | awk -F' ' '{if($4=="'"${PROGRAM_NAME}"'") print $1}' | wc -l`
if [ ${COUNT} -ge 1 ]; then
	echo "kill the program fail"
	#8.	如果程序未杀死，则kill -9再次杀死
	kill  -9 ${PROGRAME_PID}
	if [ $? -eq 0 ]
	then
	   echo "kill success!!!"
	else
	   echo "kill fail!!!"
	   #9.	＃杀不死则记录错误日志
	   echo "Time[$(date +%Y%m%d%H%M%S)] kill  ${PROGRAME_PID} fail!!!">>${INSTALL_DIR}/log/shell.log
	fi
fi
#10.cd 返回用户执行位置
cd ${USER_PATH}

