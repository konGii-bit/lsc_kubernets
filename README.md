# Kubernetes NGINX + NFS Example

A simple Kubernetes setup using:

- **NGINX** as an HTTP server
- **NFS** for shared persistent storage
- **Helm** to install the NFS provisioner

## Requirements

- [Minikube](https://minikube.sigs.k8s.io/docs/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)
- `envsubst` (for rendering templates)

  
## Usage

1. **Configure environment variables**  
   Create `.env` from `.env.example` file to customize ports, PVC names, and other settings.

2. **Render Kubernetes manifests**

   ```bash
   ./render.sh

3. **Deploy the stack**

   ```bash
   ./deploy.sh
