
data "aws_availability_zones" "available" {}

data "aws_ami" "latest_amazon_linux" {
    owners = ["137112412989"]
    most_recent = true
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

output "web_loadbalancer_url" {
    value = aws_elb.web_lb.dns_name
}

output "db_host" {
    value = aws_db_instance.db-wp.address
}
output "db_nane" {
    value = aws_db_instance.db-wp.name
}
output "db_user" {
    value = aws_db_instance.db-wp.username
}
output "db_password" {
    value = aws_db_instance.db-wp.password
}

output "efs_dnsname" {
    value = aws_efs_file_system.efs-wp.dns_name
}
