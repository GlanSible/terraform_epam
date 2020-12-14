
resource "aws_efs_file_system" "efs-wp" {
    creation_token = "my-product"
    performance_mode = "generalPurpose"  
}

resource "aws_efs_mount_target" "efs-mnt-wp" {
    file_system_id = aws_efs_file_system.efs-wp.id
    subnet_id      = aws_default_subnet.default_az1.id
    security_groups = [ aws_security_group.efs_for_web.id ]  
}

resource "aws_efs_mount_target" "efs-mnt2-wp" {
    file_system_id = aws_efs_file_system.efs-wp.id
    subnet_id      = aws_default_subnet.default_az2.id
    security_groups = [ aws_security_group.efs_for_web.id ]  
}