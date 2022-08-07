#  If you don't have `kubectl` or Docker Desktop installed

If you would like to deploy this on your local machine, you can do easily by using `docker-desktop`.

Docker Desktop will install Kubernetes at your request, which will enable everything you need to deploy Pi-hole on a local Kubernetes cluster.

This is useful for:

- If you want to always protect your DNS + block nasty links on the go

Once you've installed [Docker Desktop](https://www.docker.com/products/docker-desktop/) on your preferred OS, it should be trivial to get set up.

Once Docker Desktop is running:

- Open its settings
- Navigate to Kubernetes
- Check the box "Enable Kubernetes"
- Click the button "Apply & Restart"
- Wait until the Docker Desktop restarts and Kubernetes moves from status "KUBERNETES STARTING" (orange indicator) to running (green indicator)