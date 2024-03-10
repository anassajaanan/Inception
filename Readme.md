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

```docker

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

