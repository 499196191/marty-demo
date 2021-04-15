USER_PATH_RESTART=${PWD}
SHELL_DIR_RESTART=

SHELL_DIR_RESTART="$( cd "$( dirname "$BASH_SOURCE"  )" && pwd  )"
#echo "The shell path is "${SHELL_DIR}

cd ${SHELL_DIR_RESTART}

sh  stop.sh

source ./start.sh

cd ${USER_PATH_RESTART}