# This resource creates a MySQL database named "sonar" with the specified character set and collation.
resource "mysql_database" "sonarqube" {
  default_character_set = "utf8mb3"
  default_collation     = "utf8mb3_general_ci"
  name                  = "sonar"
}

# This resource creates a MySQL user for SonarQube with the specified username and password.
# The user is associated with the MySQL database created above.
resource "mysql_user" "sonarqube" {
  user               = var.sonar_db_username
  plaintext_password = var.sonar_db_password
  host               = "iv-buildsystem-sonarqube.${var.docker_network_name}"
  depends_on         = [mysql_database.sonarqube]
}

# This resource grants all privileges to the MySQL user on the SonarQube database.
resource "mysql_grant" "sonarqube" {
  user = mysql_user.sonarqube.user
  host = mysql_user.sonarqube.host
  database = mysql_database.sonarqube.name
  privileges = ["ALL PRIVILEGES"]
  depends_on = [mysql_user.sonarqube]
}

# This resource pulls the SonarQube Docker image and keeps it locally.
resource "docker_image" "sonarqube" {
  name         = "sonarqube:lts-community"
  keep_locally = true
}

# This resource creates and configures a Docker container for SonarQube.
resource "docker_container" "sonarqube" {
  image        = docker_image.sonarqube.image_id
  name         = "iv-buildsystem-sonarqube"
  hostname     = "sonarqube"
  restart      = "unless-stopped"
  wait         = true
  wait_timeout = 120

  # Environment variables for the SonarQube container.
  env = [
    "TZ=${var.timezone}",
    "SONARQUBE_JDBC_URL=jdbc:mysql://mysql:3306/sonar?allowPublicKeyRetrieval=true",
    "SONARQUBE_JDBC_USERNAME=${var.sonar_db_username}",
    "SONARQUBE_JDBC_PASSWORD=${var.sonar_db_password}",
  ]

  # Network configuration for the SonarQube container.
  networks_advanced {
    name = var.docker_network_name
    aliases = ["sonarqube"]
  }
}
