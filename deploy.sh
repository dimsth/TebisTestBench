#!/bin/bash

ZOOKEEPER_IMAGE="zookeeper-image"
TEBIS_IMAGE="tebis-image"

# Build Docker images
echo "Building ZooKeeper image..."
if docker build -t $ZOOKEEPER_IMAGE -f Dockerfile.zookeeper .; then
    echo "ZooKeeper image built successfully."
else
    echo "Failed to build ZooKeeper image."
    exit 1
fi

echo "Building Tebis image..."
if docker build -t $TEBIS_IMAGE -f Dockerfile.tebis .; then
    echo "Tebis image built successfully."
else
    echo "Failed to build Tebis image."
    exit 1
fi

# Apply Kubernetes configurations
echo "Deploying to Kubernetes..."
if kubectl apply -f zookeeper-deployment.yaml \
   -f tebis-deployment.yaml \
   -f zookeeper-pvcs.yaml \
   -f zookeeper-service.yaml; then
    echo "Deployment complete."
else
    echo "Deployment failed."
    exit 1
fi
