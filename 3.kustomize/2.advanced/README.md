# Kustomize Example

This example demonstrates how to use Kustomize to manage different environments for a nginx deployment.

## Directory Structure

```
.
├── base
│   ├── deployment.yaml
│   ├── kustomization.yaml
├── overlays
│   ├── dev
│   │   ├── kustomization.yaml
│   │   └── replica-count.yaml
│   ├── test
│   │   ├── kustomization.yaml
│   │   └── replica-count.yaml
│   └── prod
│       ├── kustomization.yaml
│       └── replica-count.yaml
```

## Base Configuration
The base configuration contains a simple nginx deployment.

## Overlay Configurations
- **dev**: 1 replica
- **test**: 2 replicas
- **prod**: 3 replicas

## Usage

To deploy to a specific environment, run the following command:

```sh
kustomize build overlays/<environment> | kubectl apply -f -
```

Replace `<environment>` with `dev`, `test`, or `prod` to deploy to the respective environment.

## Commands

Preview the generated manifests:
```bash
# Dev environment
kubectl kustomize overlays/dev

# Test environment
kubectl kustomize overlays/test

# Prod environment
kubectl kustomize overlays/prod
```

Deploy to a specific environment:
```bash
# Dev environment
kubectl apply -k overlays/dev

# Test environment
kubectl apply -k overlays/test

# Prod environment
kubectl apply -k overlays/prod
```

Delete the deployment:
```bash
# Dev environment
kubectl delete -k overlays/dev

# Test environment
kubectl delete -k overlays/test

# Prod environment
kubectl delete -k overlays/prod
```
