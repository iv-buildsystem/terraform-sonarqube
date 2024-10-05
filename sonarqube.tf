# SonarQube Configuration

# This resource pulls the SonarQube Docker image and keeps it locally.
resource "docker_image" "sonarqube" {
  name         = "sonarqube:lts-community"
  keep_locally = true
}

# This resource creates and configures a Docker container for SonarQube.
resource "docker_container" "sonarqube" {
  image        = docker_image.sonarqube.image_id
  name         = "${var.sonar_container_prefix}sonarqube"
  hostname     = "sonarqube"
  restart      = "unless-stopped"

  #ports {
  #  internal = 9000
  #  external = 9000
  #}

  # Environment variables for the SonarQube container.
  env = [
    "TZ=${var.timezone}",
    "SONAR_JDBC_URL=${var.sonar_db_url}",
    "SONAR_JDBC_USERNAME=${var.sonar_db_username}",
    "SONAR_JDBC_PASSWORD=${var.sonar_db_password}",
  ]

  # Volumes for the SonarQube container.
  volumes {
    host_path      = var.sonar_volume_host_path
    container_path = "/opt/sonarqube/data"
  }

  # Network configuration for the SonarQube container.
  networks_advanced {
    name = data.docker_network.network.name
    aliases = ["sonarqube"]
  }

  depends_on = [postgresql_grant.sonarqube]
}
