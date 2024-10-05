# SonarQube Configuration

# This resource pulls the SonarQube Docker image and keeps it locally.
resource "docker_image" "sonarqube" {
  name         = "sonarqube:lts-community"
  keep_locally = true
}

# Create a named volume for SonarQube data
resource "docker_volume" "sonarqube_data" {
  name = "sonarqube_data"
}

# Create a named volume for SonarQube extensions
resource "docker_volume" "sonarqube_extensions" {
  name = "sonarqube_extensions"
}

# This resource creates and configures a Docker container for SonarQube.
resource "docker_container" "sonarqube" {
  image        = docker_image.sonarqube.image_id
  name         = "${var.sonar_container_prefix}sonarqube"
  hostname     = "sonarqube"
  restart      = "unless-stopped"
  network_mode = "bridge"

  # Optional port mapping
  dynamic "ports" {
    for_each = var.sonar_enable_port_mapping ? [1] : []
    content {
      internal = 9000  # Fixed internal port for SonarQube
      external = var.sonar_host_port  # Map to the host-defined port
    }
  }

  # Environment variables for the SonarQube container.
  env = [
    "TZ=${var.timezone}",
    "SONAR_JDBC_URL=${var.sonar_db_url}",
    "SONAR_JDBC_USERNAME=${var.sonar_db_username}",
    "SONAR_JDBC_PASSWORD=${var.sonar_db_password}",
  ]

  # Use the named volume for SonarQube data
  volumes {
    volume_name    = docker_volume.sonarqube_data.name
    container_path = "/opt/sonarqube/data"
    read_only      = false
  }

  # Use the named volume for SonarQube extensions
  volumes {
    volume_name    = docker_volume.sonarqube_extensions.name
    container_path = "/opt/sonarqube/extensions"
    read_only      = false
  }

  # Network configuration for the SonarQube container.
  networks_advanced {
    name = data.docker_network.network.name
    aliases = ["sonarqube"]
  }

  depends_on = [postgresql_grant.sonarqube]
}
