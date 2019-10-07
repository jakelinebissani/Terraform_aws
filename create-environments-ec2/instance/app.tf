resource "aws_instance" "web01" {
  ami             = "${var.ami}"
  subnet_id       = "${var.subnet_id}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.key_name}"
  security_groups = [""]
  tags = {
    Name = "${var.tag_name}"
  }
  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_instance" "web02" {
  ami             = "${var.ami}"
  subnet_id       = "${var.subnet_id}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.key_name}"
  security_groups = [""]
  tags = {
    Name = "${var.tag_name}"
  }
  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}
