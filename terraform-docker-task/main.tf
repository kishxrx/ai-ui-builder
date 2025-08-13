# This is the main settings block for Terraform.
terraform {
  required_providers {
    # We are telling Terraform that we need the "docker" provider.
    # Think of this as specifying an ingredient brand for our recipe.
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

# This block configures the Docker provider itself.
# It's like opening the box for the ingredient we just specified.
provider "docker" {}

# This is a "resource" block. A resource is a "thing" we want to create.
# First, we need to download the official NGINX web server image.
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# This is our second resource. This is the actual container.
# It uses the image we downloaded above to run the NGINX web server.
resource "docker_container" "nginx_container" {
  image = docker_image.nginx.image_id
  name  = "terraform-example-container"
  
  ports {
    internal = 80
    external = 8000
  }
}
