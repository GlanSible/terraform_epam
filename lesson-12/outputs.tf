output "web_loadbalancer_url" {
    value = aws_elb.web_lb.dns_name
}