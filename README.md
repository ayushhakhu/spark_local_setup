This guide walks you through setting up a fully functional **Spark Cluster** with **Spark Master**, **Spark Worker**, and **Jupyter Notebook** using Docker.

---

## **Prerequisites**

Before starting, make sure you have the following installed:

### **Step 0: Install Docker Desktop**

Download and install Docker Desktop:

* [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

### **Step 1: Install Git (if not already installed)**

Download from:

* [https://git-scm.com/install/](https://git-scm.com/install/)

---

## **Setup Instructions**

### **Step 2: Create a Project Directory**

Create a folder for your setup, for example:

```
spark_setup
```

### **Step 3: Clone the Repository**



### **Step 4: Build & Start the Cluster**

Inside the project folder, run:

```
docker-compose down && docker-compose up -d --build
```

This will:

* Build the custom Jupyter + Spark image
* Start Spark Master, Spark Worker, and Jupyter Notebook

---

### **Step 5: Verify Containers Are Running**

Open **Docker Desktop** and go to **Containers**.
You should see the following running:

* `spark-master`
* `spark-worker`
* `jupyter`

---

### **Step 6: Submit a Spark Job**

To run `job.py` inside the cluster, execute in vs code terminal:

```
docker exec -it spark-master /opt/spark/bin/spark-submit /opt/spark-app/job.py
```

---

## 🔵 **Optional Features**

### **1. Launch Jupyter Notebook with Spark**

Open the following link in your browser:

```
http://localhost:8888/lab?
```

You can now create notebooks that use Spark.

### **2. Adjust Spark Worker Memory**

If your system does not have enough RAM, you can lower memory allocation.

Edit `docker-compose.yml`:

```
SPARK_WORKER_MEMORY=8G
```

Set it to a smaller value if needed, for example:

```
SPARK_WORKER_MEMORY=4G
```

---

## ✅ Running with Podman (instead of Docker)

If you are using **Podman Desktop** on Windows, you can run the same setup with `podman` and `podman-compose`.

### **A. One-time Podman / podman-compose setup (Windows)**

- Make sure **Podman Desktop** is installed and a machine (e.g. `astro-machine`) is created and running.
- Install `podman-compose` with Python (PowerShell):

```powershell
python -m pip install --user podman-compose
$env:PATH += ";$HOME\\AppData\\Roaming\\Python\\Python310\\Scripts"
podman-compose --version
```

### **B. Start the Spark cluster with Podman**

From the project root (`spark_local_setup`):

```powershell
podman-compose down
podman-compose up -d --build
```

This will:

- Build the `local-pyspark-351:latest` Jupyter image
- Start `spark-master`, `spark-worker`, and `jupyter` containers using Podman

You can verify they are up with:

```powershell
podman ps
```

You should see containers named `spark-master`, `spark-worker`, and `jupyter`.

### **C. How to see the UIs / servers**

Once the containers are running, open these URLs in your browser on the host:

- **JupyterLab**: `http://localhost:8888/lab?`
- **Spark Master Web UI**: `http://localhost:8080`
- **Spark Worker Web UI**: `http://localhost:8081`

These come from the port mappings defined in `docker-compose.yaml`, which `podman-compose` reuses.

### **D. How to execute commands inside containers with Podman**

- **Open an interactive shell in the Jupyter container** (e.g. to inspect files, run Python, etc.):

```powershell
podman exec -it jupyter bash
```

- **Submit the example Spark job from the Spark master** (Podman equivalent of the Docker command above):

```powershell
podman exec -it spark-master /opt/spark/bin/spark-submit /opt/spark-app/job.py
```

You can adapt this to run any other script mounted under `/opt/spark-app`.

### **E. Stop the Podman-based cluster**

From the project root:

```powershell
podman-compose down
```

This will stop and remove the containers (images and volumes are kept unless you remove them explicitly with `podman rmi` / `podman volume rm`).



## copy from container to local 

podman exec -it jupyter bash
ls -R /opt/spark-output
ls -R /opt/spark-output/result

podman cp jupyter:/opt/spark-output/result ./output_result