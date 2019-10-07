# Provider que o Terraform irá utilizar
provider "aws" {
  region = "${var.region}"
}

# Security Group Configs
resource "aws_security_group" "default" {
  name = "ec2-elb-sg"

  # Liberar a porta 80 para acesso livre via Internet
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Liberar todo o tráfego de saida
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## Confiuração da Key Pair - Configuramos o caminho no variables.tf
resource "aws_key_pair" "default" {
  key_name   = "ec2-elb-key"
  public_key = "${file("${var.key_path}")}"
}

## EC2 Instance 1
resource "aws_instance" "webserver001" {
  ami             = "${var.ami}"
  instance_type   = "${var.instance_type}"
  key_name        = "${aws_key_pair.default.id}"
  security_groups = ["${aws_security_group.default.name}"]
  user_data       = "${file("user-data/webserver001.sh")}"

  tags {
    Name = "webserver001"
  }
}

# ## EC2 Instance 2
# resource "aws_instance" "webserver002" {
#   ami = "${var.ami}"
#   instance_type = "${var.instance_type}"
#   key_name = "${aws_key_pair.default.id}"
#   security_groups = ["${aws_security_group.default.name}"]
#   user_data = "${file("user-data/webserver002.sh")}"
#
#   tags {
#     Name = "webserver002"
#   }
# }

## Configuração do Load Balance
resource "aws_elb" "default" {
  name = "ec2-elb"

  ## Instâncias a serem registradas - Configuradas acima!
  instances          = ["${aws_instance.webserver001.id}"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  ## Listener Ports do Load Balance
  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  ## Health Check Configs
  ## Será um healthcheck simples HTTP
  health_check {
    target              = "HTTP:80/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }

  tags {
    Name = "ec2-elb"
  }
}
