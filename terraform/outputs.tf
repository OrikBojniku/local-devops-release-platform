output "network_name" {
  description = "Emri i rrjetit Docker"
  value       = docker_network.devops_network.name
}

output "registry_url" {
  description = "URL e regjistrit lokal"
  value       = "localhost:${var.registry_port}"
}

output "jenkins_url" {
  description = "URL e Jenkins"
  value       = "http://localhost:${var.jenkins_port}"
}

output "jenkins_container_id" {
  description = "ID e kontejnerit Jenkins"
  value       = docker_container.jenkins.id
}
