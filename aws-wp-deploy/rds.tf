
resource "aws_db_instance" "db-wp" {
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t3.micro"
    name                 = var.db_name
    username             = var.db_user
    password             = var.db_pass
    vpc_security_group_ids = [ aws_security_group.rds_for_web.id ]
#    availability_zone = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
    multi_az = true

    tags = {
        name = "db-wp"
    }          
}