terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# NEW! Instruction 1: Build the private hallway for our containers.
resource "docker_network" "private_network" {
  name = "my-private-network"
}

# Instruction 2: Build the kitchen for our Node.js Chef.
resource "docker_image" "node_app" {
  name = "node-app-image"
  build {
    context = "."
  }
}

# Instruction 3: Get the Node Chef running in its kitchen.
resource "docker_container" "node_app" {
  name  = "node_app_container"
  image = docker_image.node_app.image_id
  # ADD THIS! This puts the Chef's container in our new hallway.
  networks_advanced {
    name = docker_network.private_network.name
  }
}

# Instruction 4: Create the instructions for our Nginx Host.
resource "local_file" "nginx_conf" {
  content = <<-EOT
    events {}
    http {
      server {
        listen 80;
        location / {
          # This line will now work because Nginx can find the Node app
          # on the private network.
          proxy_pass http://${docker_container.node_app.name}:3000;
        }
      }
    }
  EOT
  filename = "${path.module}/nginx.conf"
}

# Instruction 5: Get the Nginx Host running at the front door.
resource "docker_container" "nginx" {
  name  = "nginx_host_container"
  image = "nginx:latest"
  ports {
    internal = 80
    external = 8080
  }
  volumes {
    host_path      = abspath(local_file.nginx_conf.filename)
    container_path = "/etc/nginx/nginx.conf"
    read_only      = true
  }
  # ADD THIS! This also puts the Host's container in our new hallway.
  networks_advanced {
    name = docker_network.private_network.name
  }
  # This makes sure the Chef is in the kitchen BEFORE the
  # Host starts working.
  depends_on = [
    docker_container.node_app
  ]
}
