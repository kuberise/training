# Building a Helm Chart from Scratch

This directory serves as a starting point for learning how to build a Helm Chart from scratch. This guide will walk you through the process of creating, structuring, and templating your own Helm Chart.

---

## 1. Creating a New Chart

To initialize a standard Helm Chart structure, use the `helm create` command:

```bash
# Run this command inside this directory (or rename/replace this folder)
helm create my-new-chart
```

This will generate a folder named `my-new-chart` with the following default files and folders:

```
my-new-chart/
├── Chart.yaml          # Metadata about the chart (name, version, API version)
├── values.yaml         # Default configuration values for templates
├── templates/          # Directory containing Kubernetes manifest templates
│   ├── deployment.yaml # Template for a Deployment
│   ├── service.yaml    # Template for a Service
│   ├── ingress.yaml    # Template for an Ingress
│   ├── _helpers.tpl    # Reusable template snippets and helpers
│   └── NOTES.txt       # Text file displayed after a successful installation
└── charts/             # Directory for subcharts (dependencies)
```

---

## 2. Understanding the Generated Files

### `Chart.yaml`
This file contains metadata about your chart.
* `apiVersion`: Use `v2` for Helm 3 (standard).
* `name`: The name of your chart.
* `version`: The version of your chart (semver format, e.g., `0.1.0`). Increment this whenever you change the chart structure.
* `appVersion`: The version of the application inside the container (e.g., `1.27.0` for Nginx).

### `values.yaml`
This is the single source of configuration values for your templates. It contains key-value pairs that can be referenced inside your templates using Go template syntax (e.g., `{{ .Values.replicaCount }}`).

### `templates/`
This directory contains your Kubernetes manifests. However, instead of hardcoded values, they contain template directives.
For example, a simple template for a ConfigMap looks like this:

```yaml
# templates/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-config
data:
  environment: {{ .Values.environment | default "development" }}
```

---

## 3. Step-by-Step Exercise: Building a Simple Custom Chart

Let's build a simple custom chart from scratch in this directory.

### Step 1: Prepare the Chart Metadata
We already have `Chart.yaml` with:
```yaml
apiVersion: v2
name: simplechart
version: 0.0.1
```

### Step 2: Create a `values.yaml` File
Create a `values.yaml` to define default configurations:
```yaml
# values.yaml
replicaCount: 2
image:
  repository: nginx
  tag: 1.27
  pullPolicy: IfNotPresent
service:
  type: ClusterIP
  port: 80
```

### Step 3: Create the `templates/` Directory
Create a folder named `templates/` and add your templates inside it.

#### 1. Deployment Template (`templates/deployment.yaml`):
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-nginx
  labels:
    app: {{ .Release.Name }}-nginx
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Release.Name }}-nginx
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}-nginx
    spec:
      containers:
      - name: nginx
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        imagePullPolicy: {{ .Values.image.pullPolicy }}
        ports:
        - containerPort: 80
```

#### 2. Service Template (`templates/service.yaml`):
```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-nginx-service
spec:
  type: {{ .Values.service.type }}
  ports:
  - port: {{ .Values.service.port }}
    targetPort: 80
    protocol: TCP
  selector:
    app: {{ .Release.Name }}-nginx
```

---

## 4. Testing and Debugging Your Chart

Before deploying your chart to a cluster, you should validate and dry-run it:

### 1. Lint Your Chart
Check your chart for syntax errors and best practices:
```bash
helm lint .
```

### 2. Render Templates Locally
Render the template files locally with the default values to inspect the compiled YAML:
```bash
helm template my-test-release .
```

### 3. Perform a Dry-Run Install
Simulate a deployment to your cluster to verify that the API server accepts the manifests:
```bash
helm install my-test-release . --dry-run --debug
```

### 4. Deploy Your Chart
Deploy the chart to your Kubernetes cluster:
```bash
helm install my-nginx-release .
```

### 5. Upgrade the Release
Change a value (e.g., replica count) and upgrade the release:
```bash
helm upgrade my-nginx-release . --set replicaCount=3
```
