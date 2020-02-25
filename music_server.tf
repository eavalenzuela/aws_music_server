# Music server
resource "aws_instance" "music_server" {
    instance_type = "t3.medium"
    ami = data.aws_ami.ubuntu-19.id
    subnet_id = var.aws_subnet_id
    key_name = aws_key_pair.aws_key.key_name
    security_groups = [aws_security_group.music_server_sg.id]
    tags = {
        Name = var.server_name
    }
    root_block_device {
        volume_size = 12
        volume_type = "gp2"
    }
}

# mount music_drive to music_server
resource "aws_volume_attachment" "music_attach" {
    device_name = "/dev/sdm"
    volume_id = aws_ebs_volume.music_drive.id
    instance_id = aws_instance.music_server.id
}

# /music EBS volume
resource "aws_ebs_volume" "music_drive" {
    availability_zone = var.aws_az
    size = var.music_vol_size_gb
    type = "gp2"
    tags = {
        Name = "music_library_volume"
    }
}

# music_server security group
resource "aws_security_group" "music_server_sg" {
    name = "music_server_sg"
    description = "standalone security group for music server"
    vpc_id = var.aws_vpc_id
    tags = {
        Name = "music_server_sg"
    }
    
    # permissive SSH
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
