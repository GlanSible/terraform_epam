
variable "region" {
    description = "The region for the deployment"
    default = "eu-north-1"
}

variable "db_name" {
    description = "db name)"
    default = "wpawsdb"   
}

variable "db_user" {
    description = "dbuser for wp-db"
    default = "wpawsuser"   
}

variable "db_pass" {
    description = "password for wp-db"
    default = "Pa$$w0rd"   
}