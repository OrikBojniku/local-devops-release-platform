variable "registry_port" {
  description = "Porta e regjistrit lokal Docker"
  type        = number
  default     = 5001
}

variable "jenkins_port" {
  description = "Porta e Jenkins"
  type        = number
  default     = 8080
}

variable "network_name" {
  description = "Emri i rrjetit Docker"
  type        = string
  default     = "devops-network"
}
