### Preparing for Your Upcoming Platform Engineering & Kubernetes Training

Dear Participant,

We are excited to welcome you to the upcoming **Platform Engineering & Kubernetes Training** workshop!

To help you get the most out of the hands-on labs and follow along with the exercises on your own machine (local or remote one), please review the program agenda and complete the local environment setup described below prior to the first session.

---

### 1. Training Program Overview

Our curriculum is divided into five key modules, bridging the gap between developers, administrators, and platform teams:

- **Module 1: Platform Engineering & IDPs (Internal Developer Platforms)**
  - Understanding the DevOps-to-Platform shift, Golden Paths, self-service infrastructure and GitOps principles.
- **Module 2: Kubernetes Core Concepts**
  - Understanding container benefits, K8s architecture (Control Plane vs. Data Plane), utilizing the `kubectl` CLI, imperative vs. declarative resource management, and deploying core resources (Pods, Deployments, Services, ConfigMaps, and Secrets).
- **Module 3: Advanced Kubernetes Workloads & Resources**
  - Deep dive into advanced scheduling (Taints/Tolerations, Node Affinity), StatefulSets for databases, DaemonSets for system agents, batch Jobs/CronJobs, Ingress routing, NetworkPolicies, and Role-Based Access Control (RBAC).
- **Module 4: Helm & Kustomize**
  - Application packaging and delivery. Learning templating, configuring `values.yaml`, and managing application environments efficiently without duplication.
- **Module 5: CKA Deep Dive & Troubleshooting**
  - Hands-on cluster administration aligned with CKA exam objectives: bootstrapping with `kubeadm`, upgrading control plane components, `etcd` backup and restore, systematic Node and Pod diagnostics, and faster `kubectl` workflows using JSONPath.

---

### 2. Local Environment Prerequisites

To actively participate in the hands-on portions of the workshop, we recommend setting up a local single-node Kubernetes cluster and its management tools on your laptop.

Please ensure you have **Docker or Docker Desktop** installed and running on your machine, as it will serve as the virtualization driver for your local cluster.

We will be using the following five lightweight tools:

1. **Minikube**: Runs a single-node local Kubernetes cluster inside a container or virtual machine on your laptop.
2. **kubectl**: The official command-line interface for running commands against Kubernetes clusters.
3. **Helm**: The package manager for Kubernetes, used to deploy packaged applications (Charts).
4. **K9s**: A powerful terminal-based UI that makes interacting with Kubernetes clusters faster, easier, and highly visual.
5. **Git**: Version control for cloning lab materials and practicing GitOps workflows.

---

### 3. Verifying Your Setup

Once the installations are complete, verify that everything is working properly by running these commands in your terminal:

1. **Start your local cluster:**
  ```bash
    minikube start
  ```
    *(Note: This might take a few minutes on the first run as it downloads the Kubernetes node image.)*
2. **Verify Kubernetes cluster access:**
  ```bash
    kubectl get nodes
  ```
    *You should see a single node named `minikube` with the status `Ready`.*
3. **Verify Helm installation:**
  ```bash
    helm version
  ```
4. **Verify Git installation:**
  ```bash
    git --version
  ```
5. **Launch the K9s Dashboard:**
  ```bash
    k9s
  ```
    *This should launch the terminal UI, showing you the active pods inside your minikube cluster. Press `:` then type `q` and press `Enter` to exit K9s.*

We look forward to an engaging and productive training session with you!

Best regards,

**Mojtaba Imani** 