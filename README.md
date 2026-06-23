![CI/CD Pipeline](https://github.com/poojithaa13/devops.ecs.project/actions/workflows/deploy.yml/badge.svg)

# DevOps CI/CD Pipeline — AWS ECS Fargate

A Node.js (Express) web application with a fully automated CI/CD pipeline using AWS-native container orchestration — from code push to live deployment with zero manual steps.

🌍 **Live:** http://ecs-alb-8970553.us-east-1.elb.amazonaws.com

---

## Architecture

```
Developer → GitHub → GitHub Actions → AWS ECR → AWS ECS (Fargate) → ALB → Users
```

---

## Tech Stack

- **App:** Node.js, Express
- **Container:** Docker, AWS ECR (Elastic Container Registry)
- **Orchestration:** AWS ECS Fargate (serverless containers)
- **Load Balancing:** AWS Application Load Balancer (ALB)
- **CI/CD:** GitHub Actions
- **Cloud:** AWS (IAM, ECR, ECS, ALB)

---

## Endpoints

| Route | Description |
|-------|-------------|
| `/` | Home page |
| `/about` | About page |
| `/health` | Health check (used by ALB target group) |

---

## CI/CD Flow

1. Developer pushes code to GitHub
2. GitHub Actions triggers automatically
3. Docker image built and pushed to AWS ECR
4. GitHub Actions forces a new ECS deployment
5. ECS launches a new task with the updated image
6. ALB health-checks the new task on `/health`
7. Traffic shifts to the new task; old task is drained
8. App live with zero manual steps

---

## Local Setup

```bash
git clone https://github.com/poojithaa13/devops.ecs.project.git
cd devops.ecs.project
npm install
node server.js
```

## Docker Setup

```bash
docker build -t devops-ecs-project .
docker run -p 3000:3000 devops-ecs-project
```

## AWS ECR

```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com
docker pull <account-id>.dkr.ecr.us-east-1.amazonaws.com/devops-ecs-project:latest
```

---

## AWS Resources Used

| Resource | Purpose |
|----------|---------|
| ECR Repository | Stores Docker images |
| ECS Cluster (Fargate) | Runs containers without managing servers |
| ECS Task Definition | Blueprint for container (image, CPU, memory, port) |
| ECS Service | Maintains desired running task count |
| Application Load Balancer | Routes traffic, performs health checks |
| Target Group | Tracks healthy/unhealthy tasks |

---

## GitHub Secrets Used

| Secret | Purpose |
|--------|---------|
| AWS_ACCESS_KEY_ID | IAM authentication |
| AWS_SECRET_ACCESS_KEY | IAM authentication |
| AWS_REGION | AWS region (us-east-1) |
| ECR_REPOSITORY | ECR repo name |
| AWS_ACCOUNT_ID | AWS account ID |
| ECS_CLUSTER | ECS cluster name |
| ECS_SERVICE | ECS service name |

---

## Project Structure

```
devops.ecs.project/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── views/
│   ├── index.html
│   └── about.html
├── server.js
├── package.json
├── package-lock.json
├── Dockerfile
├── .gitignore
└── .dockerignore
```
