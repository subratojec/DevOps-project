resource "aws_security_group" "my_ip_ssh" {
  name        = "my-ip-ssh-sg"
  description = "Allow SSH from my IP"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "my-ip-ssh-sg"
  }
}

#----- Rule for Inbound Traffics ------

resource "aws_vpc_security_group_ingress_rule" "my_ip_ssh_ingress" {
  security_group_id = aws_security_group.my_ip_ssh.id
  description       = "SSH from my IP"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_http_ingress" {
  security_group_id = aws_security_group.my_ip_ssh.id
  description       = "Allow HTTP access to Jenkins"
  from_port         = 8080
  to_port           = 8080
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

#---- Rule for Outbound Traffic ----- 

resource "aws_vpc_security_group_egress_rule" "my_ip_ssh_egress" {
  security_group_id = aws_security_group.my_ip_ssh.id
  description       = "Allow all outbound"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

# --- Jenkins Accessing Server-01 -- 
resource "aws_security_group" "jenkins_access" {
  name        = "jenkins-access-sg"
  description = "Allow ssh from Jenkins IP"
  vpc_id      = data.aws_vpc.default.id
  tags = {
    Name = "jenkins-access-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_access_ingress" {
  security_group_id = aws_security_group.jenkins_access.id
  description       = "SSH from Jenkins server"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "${var.jenkins_ip_address}/32"
}



#--- Minikube server for deploying --- 
resource "aws_security_group" "https_world" {
  name        = "https-world-sg"
  description = "Allow https from anyone"
  vpc_id      = data.aws_vpc.default.id
  tags = {
    Name = "sg-https-world"
  }
}
resource "aws_vpc_security_group_ingress_rule" "https_world_ingress" {
  security_group_id = aws_security_group.https_world.id
  description       = "Https from anywhere"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "https_world_engress" {
  security_group_id = aws_security_group.https_world.id
  description       = "Allow all outbound"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}