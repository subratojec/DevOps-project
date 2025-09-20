resource "aws_instance" "jenkins-server" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.my_ip_ssh.id]
  key_name               = var.key_pair_name

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
  tags = {
    Name = "JenkinServer"
  }

  user_data = file("user_data.sh")

}