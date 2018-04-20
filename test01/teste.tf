provider "aws" {
  region     = "us-east-1"
  shared_credentials_file = "/home/jakeline/.aws/credentials"
}
resource "aws_instance" "example" {
  ami           = "ami-97785bed"
  instance_type = "t2.micro"
}
