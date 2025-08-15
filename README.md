
# Project Portfolio: Infrastructure as code (IaC) with Terraform and Docker
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) !
[Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white) !
[NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white)

## Project Goal

This project documents a comprehensive journey through modern DevOps practices, from building a CI/CD pipeline to managing infrastructure as code. The primary objective was to master the full lifecycle of a containerized application, including automated builds, "multi-container" orchestration, and declarative infrastructure management with Terraform.

---

## Architecture and Workflow

The final architecture demonstrates a professional, multi-stage workflow controlled by code:

`Terraform Code` -> `Terraform Engine` -> `Docker Engine API` -> `(NGINX Container <=> Private Network <=> Node.js Container)`

1.  **Infrastructure as Code (IaC):** **Terraform** is used as the single source of truth to define all components: the Docker containers, the private network connecting them, and port mappings. This replaces manual `docker` commands with a declarative, version-controlled system.
2.  **CI/CD Automation:** A **Jenkins** pipeline automatically builds the application's Docker image whenever new code is pushed, ensuring a reliable and repeatable build process.

---

## Key Learnings & Troubleshooting Gauntlet

This journey combined high-level IaC concepts with a series of hands-on, real-world debugging challenges.

### IaC Concepts Mastered

* **Declarative Infrastructure:** We learned to define the **desired end state** in `.tf` files, allowing Terraform to handle the complex logic of creating, updating, and destroying resources.
* **The Plan/Apply/Destroy Cycle:** We mastered the critical workflow of using `terraform plan` for safe previews, `terraform apply` to execute changes, and `terraform destroy` for clean resource removal.
* **State Management:** We understood the role of the `terraform.tfstate` file as Terraform's "memory," which is essential for managing infrastructure over its lifecycle.

### Real-World Debugging Showcase

#### **Challenge 1: CI/CD Pipeline Setup (Jenkins)**

* **Error:** `npm: not found` during the build stage.
    * **Solution:** Resolved by replacing the minimal default agent with a **Docker Agent** (`node:20-alpine`), ensuring a consistent and dependency-complete build environment.
* **Error:** `docker: not found` (The Docker-in-Docker Problem).
    * **Solution:** Solved by mounting the host's Docker socket (`-v /var/run/docker.sock...`) into the Jenkins container, granting it permission to execute `docker` commands.

#### **Challenge 2: Multi-Container Communication (Nginx + Node.js)**

* **Error:** `502 Bad Gateway` due to network isolation.
    * **Solution:** Created a dedicated **`docker_network`** in Terraform, allowing the Nginx and Node.js containers to communicate securely over a private network.
* **Error:** `502 Bad Gateway` due to an application crash.
    * **Solution:** Inspected container logs (`docker logs`) to find a fatal error caused by a broken beta version of the `express` dependency. Pinned the version in `package.json` to a known stable release.
* **Error:** Lingering `502 Bad Gateway` due to a stale cache.
    * **Solution:** After fixing the code, the issue persisted. A full system cleanup with **`docker system prune -a -f`** cleared Docker's cache, forcing a fresh image rebuild with the corrected code.

---

## Future Development: The AI UI Builder Vision

This project serves as the essential foundational groundwork for a more ambitious future application: an **AI UI Builder**. The robust IaC and CI/CD skills practiced here are the critical building blocks required to design, deploy, and manage the complex backend systems needed for such an advanced tool.

 
