terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "= 3.0.2"
    }
    mysql = {
      source  = "bangau1/mysql"
      version = "= 1.10.4"
    }
  }
}

provider "docker" {
}

data "docker_network" "network" {
  name = var.docker_network_name
}
