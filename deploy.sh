#!/bin/bash

set -e

echo "Starting Minikube cluster..."
minikube start

echo "Adding Helm repository for NFS server provisioner..."
helm repo add nfs-ganesha-server-and-external-provisioner https://kubernetes-sigs.github.io/nfs-ganesha-server-and-external-provisioner/
helm repo update

echo "Installing NFS provisioner and configuring StorageClass 'lab'..."
helm install nfs-server-provisioner nfs-ganesha-server-and-external-provisioner/nfs-server-provisioner \
  --set storageClass.name=lab

echo "Creating PersistentVolumeClaim using 'lab' StorageClass..."
kubectl apply -f pvc-lab.yaml

echo "Deploying Nginx server with NFS-mounted volume..."
kubectl apply -f nginx-deployment.yaml

echo "Creating NodePort service for Nginx..."
kubectl apply -f nginx-nodeport-service.yaml

echo "Launching Kubernetes Job to write sample index.html file..."
kubectl apply -f nfs-write-job.yaml

echo "Waiting for Nginx pod to become ready..."
kubectl wait --for=condition=ready pod -l app=nginx-nfs --timeout=60s

echo "Opening Nginx service in default browser..."
minikube service nginx-service
