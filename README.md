# Docker Cheat Sheet — Mac Notes (Beginner friendly)

Copy this whole note and paste into the Mac Notes app. The layout uses simple headings, short explanations, and command blocks so it stays readable in Notes.

---

## Quick Intro
Docker packages applications and their dependencies into containers — lightweight, portable environments you can run anywhere.

---

## Helpful Mac commands
- Open Terminal: Press ⌘ + Space, type `Terminal`, Enter
- Docker Desktop for Mac: install from [Docker Hub](https://hub.docker.com/) and run the Docker app.

---

## 1) Check Docker & Help
Command:
```
docker --version
docker --help
```
Why: Verify Docker installed and get help for commands.

---

## 2) Search, Pull & List Images
Syntax:
```
docker search <image_name>     # find images on Docker Hub
docker pull <image_name>       # download image locally
docker images                  # list local images
docker rmi <image_id|name>     # remove image
```
Example:
```
docker search nginx
docker pull nginx
docker images
docker rmi nginx
```
Why: Images are blueprints for containers. Pull to download, list to inspect.

---

## 3) Run Containers (Basic)
Syntax:
```
docker run <image>                     # run once in foreground
docker run -d <image>                  # run detached (background)
docker run -it <image> /bin/bash       # interactive shell inside container
docker ps                              # list running containers
docker ps -a                           # list all containers
docker stop <container_id|name>        # stop a running container
docker rm <container_id|name>          # remove a container
```
Example:
```
docker run -d --name mynginx -p 8080:80 nginx
# visit http://localhost:8080 to see nginx page
docker run -it ubuntu /bin/bash
```
Why: Containers are running instances of images. Use -d for daemons, -p to map ports, -it for shells.

---

## 4) Ports, Names & Environment
Syntax:
```
docker run -d --name <name> -p <host_port>:<container_port> -e KEY=VALUE <image>
```
Example:
```
docker run -d --name myapp -p 3000:3000 -e NODE_ENV=production node:18
```
Why: `-p` exposes container ports to your Mac. `-e` sets environment variables.

---

## 5) Volumes (Persist data)
Commands:
```
docker volume create mydata
docker run -d --name db -v mydata:/var/lib/mysql mysql
docker volume ls
docker volume rm mydata
```
Why: Volumes store data outside the container so it persists across restarts/removal.

---

## 6) Inspect & Logs
Commands:
```
docker inspect <container_id|name>    # shows JSON with details
docker logs <container_id|name>       # view container logs
docker logs -f <container>            # follow logs (stream)
docker stats <container>              # live resource usage
```
Why: Inspect gives configuration details; logs help debug.

---

## 7) Building Images (Dockerfile)
Example Dockerfile (simple):
```
# Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .
CMD ["node", "server.js"]
```
Build and run:
```
docker build -t my-node-app .
docker run -d --name node-app -p 3000:3000 my-node-app
```
Why: Dockerfile defines how to build a custom image. Build creates the image, run starts it.

---

## 8) Docker Compose (multi-container apps)
docker-compose.yml example:
```
version: '3.8'
services:
  web:
    build: .
    ports:
      - "8080:80"
  db:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: example
    volumes:
      - dbdata:/var/lib/mysql
volumes:
  dbdata:
```
Commands:
```
docker-compose up        # start services (attach logs)
docker-compose up -d     # start in background
docker-compose down      # stop and remove containers/networks
```
Why: Compose manages multiple containers that form an app (web + db, etc).

---

## 9) Networking Basics
Commands:
```
docker network ls
docker network create mynet
docker run -d --network mynet --name a alpine sleep 1000
docker run -d --network mynet --name b alpine sleep 1000
docker network connect mynet <container>
```
Why: Networks let containers talk to each other. Docker Compose sets up a network automatically.

---

## 10) Cleanup
Commands:
```
docker system prune           # remove stopped containers, unused networks, dangling images
docker images prune           # remove dangling images
docker container prune        # remove stopped containers
```
Warning: These delete data — use carefully.

---

## 11) Tips & Best Practices (Beginner)
- Use specific image tags (e.g., `node:18-alpine` instead of `node:latest`) for reproducibility.
- Keep Dockerfile layers small (combine RUN steps when reasonable).
- Use volumes for databases and data you want to keep.
- Run `docker ps` and `docker logs` when things don’t behave as expected.
- For Mac: Docker Desktop uses a VM under the hood — file sharing with host can be slower; prefer copying necessary files into the image for production.

---

## 12) Useful Commands Cheat Sheet (copy-friendly)
```
# Images
docker pull nginx
docker images
docker rmi <image>

# Containers
docker run -d --name <name> -p 8080:80 nginx
docker run -it ubuntu /bin/bash
docker ps
docker ps -a
docker stop <container>
docker rm <container>

# Build
docker build -t my-image .
docker run my-image

# Compose
docker-compose up -d
docker-compose down

# Volumes & Networks
docker volume create data
docker volume ls
docker network create mynet

# Inspect & Logs
docker inspect <container>
docker logs -f <container>

# Cleanup
docker system prune
```

---

## 13) Learning resources
- Official docs: [https://docs.docker.com/](https://docs.docker.com/)
- Docker Hub: [https://hub.docker.com/](https://hub.docker.com/)
- Dockerfile best practices: [https://docs.docker.com/develop/develop-images/dockerfile_best-practices/](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

---

If you want, I can:
- Convert this to a one-page printable note,
- Make a version with only the most essential commands,
- Or produce separate small notes per topic (Images, Containers, Compose) for easier organization.
