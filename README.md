# AppleBiteCo. CI/CD Pipeline Project
**DevOps Certification Project**

## 🎯 Project Objective
To implement a robust, automated CI/CD pipeline for AppleBiteCo. to deliver frequent product updates with high reliability. This project solves the complexity of managing multiple frameworks and modular components by automating provisioning, building, and deployment.

## 🛠️ Tech Stack
*   **Version Control:** Git & GitHub
*   **CI/CD Orchestrator:** Jenkins
*   **Configuration Management:** Ansible
*   **Containerization:** Docker
*   **Application Framework:** PHP

## 🏗️ Pipeline Architecture
The pipeline follows a five-stage automated workflow:
1.  **Source:** Detects a push to the master branch and pulls the latest code.
2.  **Provision:** Uses **Ansible** to verify and install Docker on remote servers.
3.  **Build & Containerize:** Uses **Docker** to package the PHP app into a portable image.
4.  **Deploy to Test:** Automatically deploys the container to the Staging/Test environment.
5.  **Deploy to Production:** A manual approval stage that triggers deployment to the live server upon a "click of a button."

## 🚀 How to Run This Project

### 1. Prerequisites
*   Jenkins installed with the **Ansible Plugin**.
*   Docker installed on the Jenkins server.
*   Two remote servers (Test and Production) with SSH access.

### 2. Configuration
*   **Jenkins Credentials:** Add an "SSH Username with private key" named `test-server-key` for server access.
*   **Jenkins Tools:** Configure Ansible under "Global Tool Configuration" with the name `ansible-local`.
*   **Inventory:** Update `hosts.ini` with your specific Server IPs.

### 3. Execution
Simply push a change to your GitHub repository. Jenkins will detect the webhook, trigger the pipeline, and wait for your final approval at the **Production** stage.

## 🛠️ Troubleshooting & Resilience
During development, the following infrastructure hurdles were overcome:
*   **Disk Space Optimization:** Resolved "Waiting for next available executor" by lowering disk thresholds and clearing `/tmp` storage.
*   **Memory Management:** Implemented **2GB Swap Space** to prevent Jenkins crashes on low-RAM cloud instances.
*   **Permission Hardening:** Integrated the `jenkins` user into the `docker` group to enable secure image building.
*   **SSH Automation:** Configured `ANSIBLE_HOST_KEY_CHECKING=False` to allow non-interactive provisioning of remote nodes.

---
**Developed by:** DevOps8883
**Project Status:** Successfully Completed / Deployment Active

<img width="935" height="407" alt="ab" src="https://github.com/user-attachments/assets/af1b96d2-7931-4368-a671-179fa8e916f0" />

<img width="923" height="406" alt="ac" src="https://github.com/user-attachments/assets/1b1cf4ef-d1ea-4b06-8a33-6bfce7db6859" />

<img width="938" height="473" alt="ad" src="https://github.com/user-attachments/assets/8cc8d1bb-d9f0-4ff8-896a-bb82a9bb4f45" />



