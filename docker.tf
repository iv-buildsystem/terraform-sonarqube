# Docker Configuration

provider "docker" {
  host = var.docker_host
}

data "docker_network" "network" {
  name = var.docker_network
}
