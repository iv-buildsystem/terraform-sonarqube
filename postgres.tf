# PostgreSQL Configuration

provider "postgresql" {
  host = var.postgres_host
  port = var.postgres_port
  username = var.postgres_root_user
  password = var.postgres_root_password
  sslmode = "disable"
}

# Create the SonarQube database
resource "postgresql_database" "sonarqube" {
  name = "sonarqube"
}

# Create a PostgreSQL user
resource "postgresql_role" "sonarqube" {
  name     = var.sonar_db_username
  password = var.sonar_db_password
  login    = true
}

# Grant privileges to the PostgreSQL user
resource "postgresql_grant" "sonarqube" {
  role        = postgresql_role.sonarqube.name
  database    = postgresql_database.sonarqube.name
  schema      = "public"
  object_type = "schema"
  privileges  = ["CREATE", "USAGE"]
}
