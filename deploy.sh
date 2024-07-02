#!/bin/bash

# Apply Kubernetes configurations
echo "Deploying to Kubernetes..."
if microk8s kubectl apply -f zookeeper-deployment.yaml \
   -f tebis-deployment.yaml \
   -f tebis-service.yaml \
   -f zookeeper-service.yaml \
   -f zookeeper-datalog-pvc.yaml \
   -f zookeeper-data-pvc.yaml \
   -f zookeeper-datalog-pv.yaml \
   -f zookeeper-data-pv.yaml; then
    echo "Deployment complete."
else
    echo "Deployment failed."
    exit 1
fi