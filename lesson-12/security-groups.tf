
resource "aws_security_group" "wp_web_serv" {
    name = "wp-sec-group"

    dynamic "ingress" {
        for_each = ["80", "443"]
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        name = "wp-sec-group"
    }
}

resource "aws_security_group" "efs_for_web" {
    name = "efs-sec-group"

    ingress {      
      from_port = 2049
      to_port = 2049
      protocol = "tcp"
      cidr_blocks = [ aws_default_subnet.default_az1.cidr_block, aws_default_subnet.default_az2.cidr_block ]      
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ aws_default_subnet.default_az1.cidr_block, aws_default_subnet.default_az2.cidr_block ]
    }

    tags = {
        name = "efs-sec-group"
    }
}

resource "aws_security_group" "rds_for_web" {
    name = "rds-sec-group"

    ingress {      
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = [ aws_default_subnet.default_az1.cidr_block, aws_default_subnet.default_az2.cidr_block ]      
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ aws_default_subnet.default_az1.cidr_block, aws_default_subnet.default_az1.cidr_block ]
    }

    tags = {
        name = "efs-sec-group"
    }     
}