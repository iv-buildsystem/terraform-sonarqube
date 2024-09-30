# --== General ==--
variable "timezone" {
  type    = string
}

# --== Docker ==--
variable "docker_network_name" {
  type    = string
}

# --== MySQL ==--
variable "mysql_endpoint" {
  type      = string
  default   = "localhost:3306"
}
variable "mysql_username" {
  type      = string
  default   = "root"
}
variable "mysql_password" {
  type      = string
  sensitive = true
}

# --== SonarQube ==--
variable "sonar_db_username" {
  type      = string
}

variable "sonar_db_password" {
  type      = string
  sensitive = true
}
