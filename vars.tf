# --== General ==--
variable "timezone" {
  type    = string
}

# --== Docker ==--
variable "docker_host" {
  type    = string
  default = "unix:///var/run/docker.sock"
}

variable "docker_network_name" {
  type    = string
}

# --== PostgreSQL ==--
variable "postgresql_host" {
  type      = string
  default   = "localhost:5432"
}

variable "postgresql_port" {
  type      = number
  default   = 5432
}

variable "postgresql_username" {
  type      = string
  default   = "postgres"
}

variable "postgresql_password" {
  type      = string
  sensitive = true
}

# --== SonarQube ==--
variable "sonar_container_prefix" {
  type    = string
  default = "iv-buildsystem-"
}

variable "sonar_volume_host_path" {
  type    = string
}

variable "sonar_db_url" {
  type      = string
}

variable "sonar_db_username" {
  type      = string
  default   = "sonarqube"
}

variable "sonar_db_password" {
  type      = string
  sensitive = true
}
