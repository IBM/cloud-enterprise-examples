variable "project_name" {}
variable "environment" {}

variable "public_key" {}

variable "logdna_ingestion_key" {}
variable "logdna_api_host" {
  default = "api.us-south.logging.cloud.ibm.com"
}
variable "logdna_log_host" {
  default = "logs.us-south.logging.cloud.ibm.com"
}
variable "private_key_file" {
  default = "~/.ssh/id_rsa"
}

variable "port" {
  default = 8080
}
variable "max_size" {
  default = 3
}
