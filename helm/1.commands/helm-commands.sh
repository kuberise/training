#!/bin/bash
# these are most common helm commands and use cases

# Add a repository to your local Helm installation (https://github.com/nginxinc/helm-charts)
helm repo add nginx-stable https://helm.nginx.com/stable

# Update your repository to ensure you have the latest charts available
helm repo update

# Show the list of repositories you have added to your local Helm installation
helm repo list

# Search for a chart in the repositories you have added and check the latest version
helm search repo nginx

# Show the default configuration values for the nginx-ingress chart
helm show chart nginx-stable/nginx-ingress
helm show values nginx-stable/nginx-ingress
helm show values nginx-stable/nginx-ingress | code -
helm pull nginx-stable/nginx-ingress
# or inspect a chart and get values from vscode extension

# Show the template files for the nginx-ingress chart
helm template mynginx nginx-stable/nginx-ingress
helm template mynginx nginx-stable/nginx-ingress | code -

# Install a chart from the repository (replace "mynginx" and "nginx" as required)
helm install mynginx nginx-stable/nginx-ingress

# Upgrade the release with a new version or updated configuration
helm upgrade --install mynginx nginx-stable/nginx-ingress --set controller.replicaCount=2

# Show the revision history for a particular release
helm history mynginx

# Roll back to a previous release revision (replace "1" with the desired revision)
helm rollback mynginx 1

# Uninstall a release when it is no longer needed
helm uninstall mynginx

# List all releases deployed in your cluster
helm list -A

# Perform a dry run of an install to debug potential issues without actual changes
helm install mynginx nginx-stable/nginx-ingress --dry-run --debug

## ---------- OCI Registry  -------------

helm show chart oci://registry-1.docker.io/bitnamicharts/nginx
helm show values oci://registry-1.docker.io/bitnamicharts/nginx
helm pull oci://registry-1.docker.io/bitnamicharts/nginx
helm install nginx oci://registry-1.docker.io/bitnamicharts/nginx
helm template nginx oci://registry-1.docker.io/bitnamicharts/nginx
