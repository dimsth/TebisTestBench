#!/bin/bash

ZOOKEEPER_IMAGE="zookeeper-image:lastest"
TEBIS_IMAGE="tebis-image:latest"

# Build Docker images
echo "Building ZooKeeper image..."
if docker build -t $ZOOKEEPER_IMAGE -f zookeeper/Dockerfile.zookeeper zookeeper/; then
    docker push dstath/zookeeper-image:latest
    echo "ZooKeeper image built and pushed successfully."
else
    echo "Failed to build ZooKeeper image."
    exit 1
fi

echo "Building Tebis Base image..."
if docker build -t tebis-base:latest -f tebis/Dockerfile.base tebis/; then
    docker push dstath/tebis-base:latest
    echo "Tebis Base image built and pushed successfully."
else
    echo "Failed to build Tebis Base image."
    exit 1
fi

echo "Building Tebis App image..."
if docker build -t $TEBIS_IMAGE -f tebis/Dockerfile.app tebis/; then
    docker push dstath/tebis-app:latest
    echo "Tebis App image built and pushed successfully."
else
    echo "Failed to build Tebis App image."
    exit 1
fi

# Apply Kubernetes configurations
echo "Deploying to Kubernetes..."
if microk8s kubectl apply -f zookeeper-deployment.yaml \
   -f tebis-deployment.yaml \
   -f zookeeper-pvcs.yaml \
   -f zookeeper-service.yaml; then
    echo "Deployment complete."
else
    echo "Deployment failed."
    exit 1
fi