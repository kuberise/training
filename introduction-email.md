### Subject: Preparing for Your Upcoming Platform Engineering & Kubernetes Training

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
  - An administration deep dive covering cluster bootstrapping via `kubeadm`, cluster upgrades, `etcd` backup and restore operations, Node/Pod troubleshooting, and command-line efficiency with JSONPath.

---

### 2. Local Environment Prerequisites

To actively participate in the hands-on portions of the workshop, we recommend setting up a local single-node Kubernetes cluster and its management tools on your laptop.

Please ensure you have **Docker Desktop**, **Rancher Desktop**, or **Podman** installed and running on your machine, as it will serve as the virtualization driver for your local cluster.

We will be using the following four lightweight tools:

1. **Minikube**: Runs a single-node local Kubernetes cluster inside a container or virtual machine on your laptop.
2. **kubectl**: The official command-line interface for running commands against Kubernetes clusters.
3. **Helm**: The package manager for Kubernetes, used to deploy packaged applications (Charts).
4. **K9s**: A powerful terminal-based UI that makes interacting with Kubernetes clusters faster, easier, and highly visual.

#### Installation Instructions by Operating System

Choose the section corresponding to your operating system to install the tools.

##### Option A: macOS (Using Homebrew)

If you have Homebrew installed, you can set up all tools with a single command. Open your terminal and run:

```bash
brew install minikube kubectl helm k9s
```

##### Option B: Windows (Using Winget or Chocolatey)

Open PowerShell or Command Prompt as an Administrator and run one of the following options:

- **Using Winget (Recommended):**
  ```powershell
  winget install -e --id Kubernetes.minikube
  winget install -e --id Kubernetes.kubectl
  winget install -e --id Helm.Helm
  winget install -e --id DerbySoft.K9s
  ```
- **Using Chocolatey:**
  ```powershell
  choco install minikube kubernetes-cli kubernetes-helm k9s
  ```

##### Option C: Linux

Open your terminal and run the respective package commands or download the official binaries:

- **kubectl:**
  ```bash
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  ```
- **Minikube:**
  ```bash
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
  ```
- **Helm:**
  ```bash
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  ```
- **K9s:**
Download the latest binary from the [K9s GitHub Releases](https://github.com/derailed/k9s/releases) page and move it to `/usr/local/bin/`.

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
4. **Launch the K9s Dashboard:**
  ```bash
    k9s
  ```
    *This should launch the terminal UI, showing you the active pods inside your minikube cluster. Press `:` then type `q` and press `Enter` to exit K9s.*

If you experience any difficulties or have questions during the installation process, please reach out to us by replying to this email, and we will gladly assist you.

We look forward to an engaging and productive training session with you!

Best regards,

**The Platform Engineering & Training Team**
