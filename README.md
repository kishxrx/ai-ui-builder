# AI UI Builder - Foundational Backend Deployment

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white) ![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white) ![Render](https://img.shields.io/badge/Render-%46E3B7.svg?style=for-the-badge&logo=render&logoColor=white)

##  Project Goal

The **`ai-ui-builder`** project is the foundational first phase for a future, more ambitious application. 

The immediate goal, which has been successfully achieved here, was to build and deploy a robust, scalable backend infrastructure using modern DevOps principles. This project creates the essential groundwork and proves out the core deployment pipeline—from local code to a live, public URL—upon which the future **AI UI Builder** will be constructed.

---

##  Key Improvisation: A Custom Node.js Backend

Instead of just deploying a static "under construction" page, this project was elevated by developing a **custom Node.js backend using the Express framework**. This transformed a simple infrastructure task into a full-stack application, demonstrating skills in both backend development and modern DevOps orchestration.

---

##  Architecture

The application runs in a multi-container environment, following a professional reverse proxy pattern.

`User's Browser` -> `NGINX Container (Host)` -> `Private Network` -> `Node.js Container (Chef)`

* The **Nginx Container** acts as the public-facing gateway, handling all incoming web traffic.
* The **Node.js Container** runs the custom Express application in isolation.
* A **Private Network** allows the two containers to communicate securely and efficiently.

---

##  Cloud Deployment on Render

This project is deployed live on the internet for free using **Render**. The deployment was achieved entirely through the web interface, without needing a command line.

### Deployment Process
The key was to add the necessary configuration files directly to our existing GitHub repository:

1.  **`render.yaml`:** A blueprint file was created to define the two services (the private Node.js app and the public Nginx web service) and how they connect.
2.  **`Dockerfile.nginx` & `nginx.conf`:** A dedicated Dockerfile and Nginx configuration were added to build our reverse proxy correctly in Render's cloud environment.

Once these files were in the repository, we connected it to a new **Blueprint** service on Render. Render automatically read the configuration, built both containers, established the private network, and deployed the application, making it available to the world via a public `.onrender.com` URL.

---

## How to Run Locally

### Prerequisites
* **Docker:** Must be installed and running.
* **Terraform:** Must be installed.

### Instructions
1.  **Initialize Terraform:** `terraform init`
2.  **Build and Deploy:** `terraform apply` (and type `yes`)
3.  **Access The Application:** [http://localhost:8080](http://localhost:8080)
4.  **Shutdown and Cleanup:** `terraform destroy`

---

##  Debugging & Key Learnings

This project involved overcoming several real-world technical challenges. Each error provided a critical learning opportunity.

1.  **Inter-Container Communication:** Solved a `502 Bad Gateway` error by creating a `docker_network` to allow the Nginx and Node.js containers to communicate.
2.  **Dependency Mismatches:** Fixed another `502` error by inspecting logs (`docker logs`) and correcting the `express` version in `package.json` from a broken beta version to a stable one.
3.  **Docker Cache Issues:** Resolved the final, lingering `502` error by performing a full system cleanup with `docker system prune -a -f`, which forced Docker to rebuild the image from scratch with our corrected code.
 
