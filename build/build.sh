##!/usr/bin/env bash

set -x

name="terraform"

docker_executor=$(which docker)
jq_executor=$(which jq)

# echo $CODEBUILD_BUILD_NUMBER

# $docker_executor rm $name
# $docker_executor rmi $name

REGION=$AWS_REGION
ACCOUNTID=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .accountId)
REPO=${ACCOUNTID}.dkr.ecr.${REGION}.amazonaws.com
GIT_SHA=$(git rev-parse HEAD 2>/dev/null | cut -c 1-7)
version="${GIT_SHA}"

image="${image:-$REPO/$name}"
ecr_image="${REPO}/${name}"

$docker_executor build -t $image:$version -t $ecr_image:$version

$docker_executor tag $image:$version $image:$CODEBUILD_BUILD_NUMBER
$docker_executor tag $image:$version $image:latest
$docker_executor tag $ecr_image:$version $ecr_image:$CODEBUILD_BUILD_NUMBER
$docker_executor tag $ecr_image:$version $ecr_image:latest
