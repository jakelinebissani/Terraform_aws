variable "region" {
  description = "AWS Region"
  default     = "us-east-2"
}
variable "key_name" {
  description = "key pub"
  default     = "key"
}
variable "ami" {
  description = "AMI"
  default     = "ami-0c929bde1796e1484"
}
# Classe da instância que será utilizada
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
variable "tag_name" {
  description = "web-hom"
  default     = "web-hom"
}
variable "env_name" {
  description = "hom"
  default     = "hom"
}
variable "subnet_id" {
  description = "sub-hom-pub"
  default     = ""
}
