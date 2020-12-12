
provider "aws" {
    region = var.region
}

#-----------------------------------------------

resource "aws_launch_configuration" "web_config" {
//  name          = "webserver-ha-lb"
  name_prefix = "webserver-ha-lb-"
  image_id      = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"
  security_groups = [aws_security_group.wp_web_serv.id, aws_security_group.efs_for_web.id, aws_security_group.rds_for_web.id]
  user_data = templatefile("web_data.sh.tpl", {
    f_name = "Gleb",
    l_name = "Obraztsov"
    names = ["Dima", "Sergey", "Misha", "Timur", "Konditer", "GordeYYY"]
    })

  lifecycle {
      create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
//    name = "webserver-HA-LB"
    name_prefix = "web-${aws_launch_configuration.web_config.name}"
    launch_configuration = aws_launch_configuration.web_config.name
    min_size = 2
    max_size = 2
    min_elb_capacity = 2
    vpc_zone_identifier = [aws_default_subnet.default_az1.id,aws_default_subnet.default_az2.id]
    health_check_type = "ELB"
    load_balancers = [aws_elb.web_lb.name]

    dynamic "tag" {
    for_each = {
        Name = "Webserver-in-ASG"
        Owner = "Glan Sible"
        TAGKEY = "TAGVALUE"
        }
    content {
        key = tag.key
        value = tag.value
        propagate_at_launch = true    
        }
    }
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_elb" "web_lb" {
    name = "webserver-ha-lb"
    availability_zones = [data.aws_availability_zones.available.names[0],data.aws_availability_zones.available.names[1]]
    security_groups = [aws_security_group.wp_web_serv.id]
    listener {
        lb_port = 80
        lb_protocol = "http"
        instance_port = 80
        instance_protocol = "http"
    }
    tags = {
        Name = "webserver-ha-lb"
    }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "Default subnet for ${data.aws_availability_zones.available.names[0]}"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "Default subnet for ${data.aws_availability_zones.available.names[1]}"
  }
}