# Advanced Kustomize Example

This directory demonstrates advanced Kustomize features used to manage environment-specific configurations for a microservice. It showcases how to apply name prefixes, generate ConfigMaps dynamically from files, apply precise JSON patches (RFC 6902), and propagate common labels.

## Directory Structure

```
.
├── base/
│   ├── deployment.yaml      # Common deployment manifest
│   ├── service.yaml         # Common service manifest
│   └── kustomization.yaml   # Base kustomization (adds project labels)
└── overlays/
    ├── dev/
    │   ├── config.properties    # Dev-specific configuration file
    │   └── kustomization.yaml   # Dev overlay (patches replicas, injects env, generates CM)
    └── prod/
        ├── config.properties    # Prod-specific configuration file
        └── kustomization.yaml   # Prod overlay (patches replicas, injects env, generates CM)
```

---

## Key Advanced Features Demonstrated

### 1. Common Labels with Selector Propagation
In `base/kustomization.yaml`, we define:
```yaml
labels:
- includeSelectors: true
  pairs:
    project: alpha
```
By setting `includeSelectors: true`, Kustomize automatically adds the `project: alpha` label to the metadata of all resources, **and** automatically adds it to the label selectors of the Deployment and Service. This ensures they remain perfectly bound without manual selector editing.

### 2. Name Prefixes (`namePrefix`)
In the overlays (e.g., `overlays/dev/kustomization.yaml`), we define:
```yaml
namePrefix: dev-
```
Kustomize prepends `dev-` to all resource names (e.g., `simple-app` becomes `dev-simple-app`). It also automatically updates any references to these resources (such as a Service's selector or a Deployment's volume mounts) so that the cluster configuration doesn't break.

### 3. ConfigMap Generators (`configMapGenerator`)
Instead of writing raw ConfigMap manifests, we generate them dynamically from properties files:
```yaml
configMapGenerator:
- files:
  - config.properties
  name: app-config
```
Kustomize reads `config.properties`, creates a ConfigMap named `dev-app-config-<hash>`, and appends a unique content hash to the name. 
* **Benefit**: If you update `config.properties` and redeploy, the ConfigMap name changes, which automatically triggers a rolling update of the Deployment using it. This solves the "stale config" issue in Kubernetes.

### 4. JSON Patches (RFC 6902)
Instead of merging partial YAML files (strategic merge patches), we use precise JSON patches in the overlays to modify specific fields:
```yaml
patches:
- patch: |-
    - op: replace
      path: /spec/replicas
      value: 1
    - op: add
      path: /spec/template/spec/containers/0/env
      value:
      - name: ENVIRONMENT
        value: development
  target:
    kind: Deployment
    name: simple-app
```
This patch:
- Replaces the replica count with `1` (or `3` in production).
- Adds an `ENVIRONMENT` environment variable to the first container (`/containers/0`) in the Pod template.

---

## Commands and Usage

### 1. Preview the Generated Manifests
To see how Kustomize compiles the base and applies the overlay patches, run:

```bash
# Dev environment
kubectl kustomize overlays/dev

# Prod environment
kubectl kustomize overlays/prod
```

Observe how:
- All resource names are prefixed (e.g., `dev-simple-app`).
- The ConfigMap is generated with a unique hash.
- The Deployment's replica count is modified.
- The `ENVIRONMENT` env variable is added.
- Labels are propagated to both metadata and selectors.

### 2. Deploy to a Specific Environment
Apply the compiled manifests directly to your cluster:

```bash
# Deploy Dev
kubectl apply -k overlays/dev

# Deploy Prod
kubectl apply -k overlays/prod
```

### 3. Clean Up Resources
Delete all resources managed by Kustomize for a specific environment:

```bash
# Delete Dev
kubectl delete -k overlays/dev

# Delete Prod
kubectl delete -k overlays/prod
```
