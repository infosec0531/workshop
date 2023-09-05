# # App server instance
resource "aws_key_pair" "private" {
  key_name   = "ntier"
  public_key = file(var.public_key_path)
  tags = {
    CreatedBy = "terraform"
  }
}

data "aws_subnet" "app" {
  filter {
    name   = "tag:Name"
    values = [var.app_subnet_names]
  }
  depends_on = [
    aws_subnet.subnet_app
  ]

}

resource "aws_instance" "appserver" {
  ami                         = var.ubuntu_ami_id
  associate_public_ip_address = true
  instance_type               = var.app_ec2_size
  key_name                    = aws_key_pair.private.key_name
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  subnet_id                   = data.aws_subnet.app.id
  tags = {
    Name = "appserver"
  }

  depends_on = [
    aws_subnet.subnet_app,
    aws_route.igwroute
  ]
}

resource "null_resource" "script_executor" {
  provisioner "remote-exec" {
    # inline = [
    #   "sudo apt update",
    # ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = aws_instance.appserver.public_ip
    }
  }
  triggers = {
    app_script_version = var.app_script_version
  }

  depends_on = [
    aws_subnet.subnet_app,
    aws_instance.appserver
  ]

}