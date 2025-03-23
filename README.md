# Solana Anchor Docker Setup

This project provides a **Docker-based** development environment for **Solana Anchor** smart contract development. The setup allows you to create workspaces, add programs, build, and test everything inside a containerized environment.

---

## 📌 Prerequisites
- **Docker** and **Docker Compose** installed on your system.
- **Solana CLI** and **Anchor CLI** are installed inside the container.

---

## 🚀 Getting Started

### 1️⃣ Build the Docker Image
Run the following command to build the Docker image:
```sh
docker compose build
```
This will create the necessary environment for your Solana Anchor workspace.

---

## 🏗️ Workspace and Program Management

### **2️⃣ Create a New Workspace**
To create a new Anchor workspace, run:
```sh
docker compose run --rm solana-anchor new-workspace <workspace-name>
```
**Example:**
```sh
docker compose run --rm solana-anchor new-workspace my_workspace
```

### **3️⃣ Create a New Program in a Workspace**
To add a new program inside a workspace, run:
```sh
docker compose run --rm solana-anchor new-program <workspace-name> <program-name>
```
**Example:**
```sh
docker compose run --rm solana-anchor new-program my_workspace my_program
```

---

## 🔨 Building and Testing

### **4️⃣ Build the Entire Workspace**
To compile all programs in a workspace, use:
```sh
docker compose run --rm solana-anchor build-workspace <workspace-name>
```
**Example:**
```sh
docker compose run --rm solana-anchor build-workspace my_workspace
```

### **5️⃣ Build a Single Program**
To build only a specific program, run:
```sh
docker compose run --rm solana-anchor build-program <workspace-name> <program-name>
```
**Example:**
```sh
docker compose run --rm solana-anchor build-program my_workspace my_program
```

### **6️⃣ Test the Entire Workspace**
To test all programs in a workspace, use:
```sh
docker compose run --rm solana-anchor test-workspace <workspace-name>
```
**Example:**
```sh
docker compose run --rm solana-anchor test-workspace my_workspace
```

### **7️⃣ Test a Single Program**
To test only a specific program, run:
```sh
docker compose run --rm solana-anchor test-program <workspace-name> <program-name>
```
**Example:**
```sh
docker compose run --rm solana-anchor test-program my_workspace my_program
```

---

## 🔹 Additional Notes
- **Workspaces and programs are created inside the `/app` directory** inside the container.
- **Ensure you have the necessary dependencies installed inside the container.**
- **Modify the `entrypoint.sh` file to customize behavior if needed.**

For any issues, check container logs with:
```sh
docker compose logs solana-anchor
```

---



Happy coding! 🚀

