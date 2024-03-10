## **Overview**

This project represents a comprehensive endeavor to create a robust, secure, and high-performance web infrastructure using Docker. By dockerizing a suite of essential services, each within its own container built from scratch, the project showcases an advanced level of container orchestration and system architecture design. Alpine Linux, known for its security, performance, and minimal footprint, serves as the base image for all containers, ensuring the infrastructure is lightweight yet capable.

### **Key Components of the Infrastructure**

- **Nginx**: Serves as the reverse proxy and entry point to the infrastructure, handling secure HTTPS connections and directing traffic efficiently.
- **WordPress with PHP-FPM**: Powers dynamic content delivery, configured for optimal performance without the overhead of Nginx.
- **MariaDB**: Provides the relational database services for WordPress, emphasizing reliability and performance.
- **Redis**: Implements server-side caching for WordPress, significantly enhancing website speed and efficiency.
- **FTP Server**: Offers a direct, managed file transfer service, simplifying content updates and maintenance for the WordPress site.
- **Adminer**: Facilitates database management through a web interface, simplifying database tasks.
- **Static Site**: A simple, yet impactful, static website showcasing features of our web server implementation, demonstrating the infrastructure's versatility.
- **Todo List Application**: A full-stack application featuring a MongoDB database, illustrating the project's capacity to support diverse applications and services.

### **Project Goals**

The primary objectives of this project are to:

1. **Demonstrate Proficiency in Docker**: Through the dockerization of multiple services from scratch, highlighting the ability to configure, manage, and orchestrate complex, multi-container environments.
2. **Ensure Security and Performance**: By utilizing Alpine Linux as the base image and implementing best practices in container setup and network configuration.
3. **Showcase Scalability and Flexibility**: Through the integration of various services into a cohesive system, designed to be easily expandable and adaptable to new requirements.

### **Implementation Highlights**

- Custom-built Docker images for all services, avoiding the use of pre-built images to ensure control over the environment and configurations.
- Strategic use of Docker volumes for persistent storage, ensuring data durability across container restarts and deployments.
- Utilization of Docker networks for secure and efficient communication between containers, facilitating a modular yet integrated system architecture.
- Deployment and orchestration with Docker Compose, enabling straightforward management of the entire infrastructure through a single declarative configuration file.

This project not only serves as a testament to the practical applications of Docker in building modern web infrastructures but also as a blueprint for designing and implementing a scalable, secure, and high-performance containerized environment.

## **Understanding Docker: Images and Containers**

### **Docker Images**

Docker images are essentially the blueprints for Docker containers. They are immutable templates that include the application code along with its dependencies, runtime, and any other file system objects required. These images are read-only and are used to create containers that can run on any system that has Docker installed.

**Key characteristics of Docker images include**:

- **Blueprints/Templates**: Images are used to instantiate Docker containers.
- **Immutability**: Once an image is created, it doesn't change. Modifications can be made in containers instantiated from the image.
- **Layers**: Each image consists of multiple layers. Docker utilizes a union file system to stack these layers into a single image. Each layer is only the set of differences from the layer before it.
- **Efficiency**: Layers are shared between images, reducing disk usage and speeding up Docker builds.
- **Dockerfile**: This is a text file with instructions to automatically build Docker images. Each instruction in a Dockerfile adds a layer to the image.

A typical Dockerfile might look like this:

```Dockerfile

# Use an existing image as a base
FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y python

# Copy files from the host to the container's filesystem
COPY . /app

# Set the working directory
WORKDIR /app

# Execute a command within the container
CMD ["python", "app.py"]

```

### **Docker Containers**

Containers are the reason we build images. They are the running instances of Docker images - where the actual applications/services reside and operate.

**Key characteristics of Docker containers include**:

- **Isolation**: Containers run isolated from each other, which ensures consistent operation across different environments.
- **Ephemeral**: Containers can be stopped, deleted, and replaced with a new instance quickly and easily.
- **Read-Write Layer**: When a container is instantiated from an image, Docker adds a read-write layer on top. Any changes made to the container only affect this layer.
- **Portability**: Containers can run on any platform without the "but it works on my machine" problem.

Creating and managing containers typically involve commands like:

```bash

docker run -d --name my_container my_image
docker ps
docker stop my_container
docker start my_container

```

### **Key Docker Commands**

- **docker build .**: Builds an image from a Dockerfile in the current directory.
- **docker run IMAGE_NAME**: Creates and starts a new container from an image.
- **docker ps**: Lists running containers, and with **`a`** it includes stopped ones.
- **docker rm CONTAINER**: Removes a container.
- **docker rmi IMAGE**: Removes an image.
- **docker image prune**: Removes unused images.
- **docker push IMAGE**: Pushes an image to a remote registry.
- **docker pull IMAGE**: Pulls an image from a registry.

## Docker Images and Containers Summary


![Docker Summary](Readme/docker-images-containers.png)


## **Managing Data & Working with Volumes**

In Docker, managing application data is critical as containers are ephemeral by nature. While images are read-only templates, containers operate with a read-write layer. However, there are challenges with persistence and interaction with the host filesystem. Docker addresses these with "Volumes" and "Bind Mounts".

### **Volumes**

Volumes are directories on the host machine, managed by Docker, that can be mapped to container directories. They are essential for data persistence and can outlive the lifecycle of a container, allowing data to survive container removals and restarts. There are two types of volumes:

- **Anonymous Volumes**: Created with **`v /some/path/in/container`** and usually removed automatically with the container.
- **Named Volumes**: Created with **`v some-name:/some/path/in/container`** and persist beyond the life of the container, ideal for continuous data persistence.

Volumes serve the purpose of storing data generated and used by containers, such as log files, uploads, and database files. Docker manages these and they're not typically intended for manual editing.

### **Bind Mounts**

Bind Mounts differ from volumes in that they allow a specific path on the host to be mapped into a container. Created with **`-v /absolute/path/on/your/host/machine:/some/path/inside/of/container`**, bind mounts are powerful during development, allowing live editing of code that's being served by a container. They're not recommended for production use, as containers should remain isolated from the host environment.

### **Key Docker Commands for Volumes and Mounts**

- **docker run -v /path/in/container IMAGE**: Create an anonymous volume inside a container.
- **docker run -v some-name:/path/in/container IMAGE**: Create a named volume inside a container.
- **docker run -v /path/on/your/host/machine:path/in/container IMAGE**: Create a bind mount.
- **docker volume ls**: List all active volumes.
- **docker volume create VOL_NAME**: Manually create a named volume (typically unnecessary).
- **docker volume rm VOL_NAME**: Remove a volume by its name.
- **docker volume prune**: Remove all unused volumes.

By strategically using volumes and bind mounts, Docker enables not just ephemeral operations but also persistent, stateful applications that reflect changes in real-time and secure your data beyond the container's life.


## Docker Volumes and Bind Mounts Summary
![Docker Volumes and Bind Mounts Summary](Readme/docker-volumes.png)


## **Networking: Docker Container and Cross-Container Communication**

In Dockerized environments, especially with complex applications, containers often need to interact. They might need to communicate with each other, with the host machine, or with external services on the World Wide Web. Docker networking provides the features necessary to facilitate these interactions seamlessly.

### **Communicating with the World Wide Web**

Containers can send HTTP requests or other kinds of requests to external servers easily, without any additional configuration. For instance:

```jsx
fetch('https://some-api.com/my-data').then(...)
```

This code will work right out of the box when running inside a container, allowing your application to interact with the world wide web.

### **Communicating with the Host Machine**

If you need to interact with services running on the host machine (like a development database), Docker offers a special hostname **`host.docker.internal`** which resolves to the host's IP address. Here's how you can use it:

```jsx
fetch('host.docker.internal:3000/demo').then(...)
```

Using **`host.docker.internal`** allows your container to communicate with the host, translating to the appropriate IP address for outgoing requests.

### **Communicating with Other Containers**

For container-to-container communication within the same Docker host, you have two main options:

1. **Direct IP Address**: Containers can be reached by their internal IP addresses, but this is not recommended since these IPs can change and are not convenient to work with.
2. **Docker Networks**: This is the recommended approach. By creating a Docker network, you can attach multiple containers to the same network, allowing them to communicate using the container names as hostnames. Here's an example of how to create a network and run containers within it:
    
    ```bash
    docker network create my-network
    docker run --network my-network --name cont1 my-image
    docker run --network my-network --name cont2 my-other-image
    ```
    
    And to communicate between containers:
    
    ```jsx
    fetch('cont1/my-data').then(...)
    ```
    
    When containers are on the same network, Docker resolves **`cont1`** to the appropriate container, handling the internal routing automatically.
    

### **Key Docker Commands for Networking**

- **docker network create SOME_NAME**: Creates a new network.
- **docker run --network NETWORK_NAME --name CONTAINER_NAME IMAGE**: Runs a container attached to a specific network.
- **docker network ls**: Lists all networks.
- **docker network rm NETWORK_NAME**: Removes a network.

Leveraging Docker's networking capabilities allows your containers to communicate effectively, whether they are reaching out to the internet, connecting to the host machine for development purposes, or talking to each other within a multi-container application.


## **Docker Networking Summary**
![Docker Networking Summary](Readme/docker-network.png)


## **Docker Compose: An Elegant Multi-Container Orchestration**

Docker Compose is an additional tool offered by the Docker ecosystem which helps with orchestration/management of multiple Containers. It can also be used for single Containers to simplify building and launching.

### **Why?**

Consider this example:

```docker
docker network create shop
docker build -t shop-node .
docker run -v logs:/app/logs --network shop --name shop-web shop-node
docker build -t shop-database
docker run -v data:/data/db --network shop --name shop-db shop-database
```

This is a very simple (made-up) example - yet you got quite a lot of commands to execute and memorize to bring up all Containers required by this application.

And you have to run (most of) these commands whenever you change something in your code or you need to bring up your Containers again for some other reason.

With Docker Compose this gets much easier.

You can put your Container configuration into a **`docker-compose.yaml`** file and then use just one command to bring up the entire environment: **`docker-compose up`**.

### **Docker Compose Files**

A **`docker-compose.yaml`** file looks like this:

```yaml
version: "3.8" # version of the Docker Compose spec which is being used

services: # "Services" are in the end the Containers that your app needs
  web:
    build: # Define the path to your Dockerfile for the image of this container
      context: .
      dockerfile: Dockerfile-web
    volumes: # Define any required volumes / bind mounts
      - logs:/app/logs
  db:
    build:
      context: ./db
      dockerfile: Dockerfile-web
    volumes:
      - data:/data/db

```

You can conveniently edit this file at any time and you just have a short simple command which you can use to bring up your Containers: **`docker-compose up`**.

You can find the full (possibly intimidating - you'll only need a small set of the available options though) list of configurations here: [Docker Compose File Documentation](https://docs.docker.com/compose/compose-file/)

Important to keep in mind: When using Docker Compose you automatically get a Network for all your Containers - so you don't need to add your own Network unless you need multiple Networks!

### **Docker Compose Key Commands**

There are two key commands:

- **docker-compose up**: Start all containers / services mentioned in the Docker Compose file
    - **`-d`**: Start in detached mode
    - **`--build`**: Force Docker Compose to re-evaluate / rebuild all images (otherwise it only does that if an image is missing)
- **docker-compose down**: Stop and remove all containers / services
    - **`-v`**: Remove all Volumes used for the Containers - otherwise they stay around even if the Containers are removed

### **Benefits of Using Docker Compose**

- **Simplified Management**: Manage your application stack with a single file.
- **Consistency Across Environments**: Ensure consistency across development, testing, and production environments.
- **Ease of Configuration**: Easily define and share your application configuration.
- **Rapid Deployment**: Make changes to your application stack and redeploy quickly with a single command.

By integrating Docker Compose into your development workflow, you embrace a powerful tool that enhances productivity, ensures consistency, and simplifies the complexity of managing multi-container applications.

