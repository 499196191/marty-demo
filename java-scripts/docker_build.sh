#!/bin/bash
echo "docker start"

#镜像库地址
DOCKER_HUB=nexus.toops.club:9090
#镜像名称
IMAGE_NAME=tong/meta
#镜像版本号
TAG=1.1.8.1
#TongMeta-x.x.x.x.tar.gz 打包的前半部分名称
RESOURCE_NAME=TongMeta

IMAGE_PATH=$DOCKER_HUB/$IMAGE_NAME:$TAG
TARPATH=$RESOURCE_NAME-$TAG.tar.gz

#登录docker
docker login $DOCKER_HUB -u tongtech -p tongtech

#删除本地镜像
LOCAL_REPOSITORY=$DOCKER_HUB/$IMAGE_NAME:$TAG
echo "${LOCAL_REPOSITORY}"

imageId=$(docker images | grep -E $DOCKER_HUB/$IMAGE_NAME | awk '{print $3}')
echo $imageId
if [ -n "$imageId" ];then
 docker rmi $imageId
fi

#根据Dockerfile镜像打包，Dockerfile放在build.sh同级目录
echo "docker build start"
if [ -e "$TARPATH" ]; then
 docker build -t $DOCKER_HUB/$IMAGE_NAME:${TAG} .
fi
echo "docker build end"

#删除私库相同的镜像
digesturl=$DOCKER_HUB/v2/$IMAGE_NAME/manifests/$TAG
digest=`curl --header "Accept:application/vnd.docker.distribution.manifest.v2+json" -Is $digesturl | awk '/Digest/ {print $NF}'`
echo "$digest"
[[ -z "$digest" ]] && { echo "not found"; } || {
 echo "镜像存在"
 delurl="$DOCKER_HUB/v2/$IMAGE_NAME/manifests/${digest%$'\r'}"
 echo "$delurl"
 rs=`curl -Is -X DELETE $delurl -u tongtech:tongtech -k | awk '/HTTP/ {print $2}'`

 echo "$rs"
}

#推送新镜像到私库
imageIdnow=$(docker images | grep -E $DOCKER_HUB/$IMAGE_NAME | awk '{print $3}')
echo $imageIdnow
if [ -n "$imageIdnow" ];then
 docker push $IMAGE_PATH
fi
echo "docker end"

