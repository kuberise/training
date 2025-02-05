#!/usr/bin/env bash

helm install chart3 .

helm upgrade chart3 . --set replicaCount=3

helm install chart3 . --set replicaCount=3 --dry-run --debug

helm template .

helm lint .

helm get manifest chart3
