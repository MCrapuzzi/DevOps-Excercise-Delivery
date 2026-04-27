#!/usr/bin/env bash
set -e

PROFILE="multinode-cluster"

minikube start -p "$PROFILE" --nodes=3
kubectl wait --for=condition=Ready nodes --all --timeout=300s

CONTROL_PLANE="$(kubectl get nodes -o name | head -n 1 | sed 's|node/||')"

for NODE in $(kubectl get nodes -o name | sed 's|node/||'); do
  if [[ "$NODE" != "$CONTROL_PLANE" ]]; then
    kubectl label node "$NODE" node-role.kubernetes.io/worker=worker --overwrite
  fi
done