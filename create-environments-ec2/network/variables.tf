variable "region" {
  description = "AWS Region"
  default     = "us-east-2"
}
variable "vpc_id" {
  description = "hom"
  default     = ""
}
# Classe da instância que será utilizada
variable "tag_name" {
  description = "web-hom"
  default     = "web-hom"
}
variable "env_name" {
  description = "hom"
  default     = "hom"
}
