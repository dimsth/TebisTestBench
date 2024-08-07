#!/bin/bash

ZOOKEEPER_IMAGE="dstath/tebis_test_bench:zookeeper"

# Build Docker images
echo "Building ZooKeeper image..."
if docker build -t $ZOOKEEPER_IMAGE -f zookeeper/Dockerfile.zookeeper zookeeper/; then
    docker push $ZOOKEEPER_IMAGE
    echo "ZooKeeper image built and pushed successfully."
else
    echo "Failed to build ZooKeeper image."
    exit 1
fi

echo "Building Tebis images..."
if docker-compose -f tebis/docker-compose.yml up --build; then
    docker push dstath/tebis_test_bench:tebis-base
    docker push dstath/tebis_test_bench:tebis-zookeeper
    docker push dstath/tebis_test_bench:tebis-app

    echo "Tebis Base image built and pushed successfully."
else
    echo "Failed to build Tebis Base image."
    exit 1
fi