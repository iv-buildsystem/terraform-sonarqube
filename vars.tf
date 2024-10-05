# --== General ==--
variable "timezone" {
  type    = string
}

# --== Docker ==--
variable "docker_host" {
  type    = string
  default = "unix:///var/run/docker.sock"
}

variable "docker_network" {
  type    = string
}

# --== PostgreSQL ==--
variable "postgres_host" {
  type      = string
  default   = "localhost:5432"
}

variable "postgres_port" {
  type      = number
  default   = 5432
}

variable "postgres_root_user" {
  type      = string
  default   = "postgres"
}

variable "postgres_root_password" {
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

variable "sonar_enable_port_mapping" {
  description = "Enable port mapping for SonarQube"
  type        = bool
  default     = false  # Default to false, meaning no port mapping
}

variable "sonar_host_port" {
  description = "Host port to map to the SonarQube container's port 9000"
  type        = number
  default     = 9000  # Default to 9000; change if needed
}
