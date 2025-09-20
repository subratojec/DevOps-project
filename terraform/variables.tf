variable "my_ip_address" {
  description = "My IP Address"
  type        = string
  sensitive   = true
}

variable "key_pair_name" {
  description = "My Key Pair Name"
  type        = string
  sensitive   = true
}

variable "jenkins_ip_address" {
  description = "Jenkins Ip address"
  type        = string
  sensitive   = true
}