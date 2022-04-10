#!/bin/bash

curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O

kubectl apply -f calico.yaml
