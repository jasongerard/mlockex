#!/usr/bin/env bash

GOOS=linux go build -o app.o

eval $(minikube docker-env)

docker build -t mlockex:latest .

kubectl --context=minikube delete pod mlockex
kubectl --context=minikube apply -f pod.yaml
until kubectl --context=minikube get pod mlockex | grep Completed; do sleep 1; done
kubectl --context=minikube logs mlockex