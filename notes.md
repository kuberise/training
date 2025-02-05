- Management of k8s
- how to use k8s
- How to create an environment
- developer/leads/consultatn/infra/PO/Architect
- Instant payment on kubernets
- problem in storage, multi zone storage



## Maximum restart count of the failing pod
  https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy

  In Kubernetes, when a container within a Pod fails, the system employs an exponential backoff strategy to manage restart attempts. This means that after each failure, Kubernetes waits for a period before attempting to restart the container, and this waiting period increases exponentially with each subsequent failure. The initial delay is typically 10 seconds, doubling with each attempt (e.g., 10s, 20s, 40s), up to a maximum delay of 5 minutes. This mechanism helps prevent rapid, repeated failures from overwhelming system resources.

  For Jobs, Kubernetes provides a backoffLimit parameter that specifies the number of retries before the Job is considered failed. Once this limit is reached, no further attempts are made to restart the Pods associated with that Job.

  Additionally, the kubelet's configuration includes a maxContainerRestartPeriod setting, which defines the maximum duration for the backoff delay when restarting containers. By default, this is set to 300 seconds (5 minutes), but it can be adjusted as needed.

## Some use case for SA permission
  - (CI/CD) pipelines often need to deploy or update applications within the cluster.
  - Monitoring and logging tools may require access to cluster resources to collect metrics and logs.
  - External services may need to interact with the cluster to perform specific tasks, such as scaling or load balancing.
  - Security tools may need to scan the cluster for vulnerabilities or misconfigurations.
  - Backup and restore processes may require access to persistent storage volumes.
  - In microservices architectures, services may need to discover and communicate with each other.
  - Custom controllers or operators running within the cluster often need to watch and manage custom resources.

## In nginx ingress controller how to route traffic based on the content of the request, body or header?
  - Ingress controllers are designed to route traffic based on the host, path, or other request attributes, such as headers or query parameters. and they typically do not inspect the content of the request body itself.

## Network policy: only report or give warning without blocking
  No, Kubernetes NetworkPolicies do not have a built-in "warning mode" because they enforce actual network rules at the CNI (Container Network Interface) level. They either allow or deny traffic, with no option to "log and allow."
