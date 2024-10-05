# PostgreSQL Configuration

provider "postgresql" {
  host = var.postgresql_host
  port = var.postgresql_port
  username = var.postgresql_username
  password = var.postgresql_password
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
  privileges  = ["ALL"]
}
