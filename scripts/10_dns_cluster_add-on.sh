#!/usr/bin/env bash

###
# Provides DNS based service discovery to applications running inside the 
# Kubernetes cluster.
###

# Deploy the kube-dns cluster add-on
kubectl create -f https://storage.googleapis.com/kubernetes-the-hard-way/kube-dns.yaml


# List the pods created by the kube-dns deployment
kubectl get pods -l k8s-app=kube-dns -n kube-system


# Verification
# Create a busybox deployment
kubectl run busybox --image=busybox --command -- sleep 3600

# List the pod created by the busybox deployment
kubectl get pods -l run=busybox


# Retrieve the full name of the busybox pod
POD_NAME=$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")


# Execute a DNS lookup for the kubernetes service inside the busybox pod
kubectl exec -ti $POD_NAME -- nslookup kubernetes
