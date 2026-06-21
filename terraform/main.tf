terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Rrjeti Docker per te gjitha kontejneret
resource "docker_network" "devops_network" {
  name = "devops-network"
}

# Regjistri lokal i imazheve Docker
resource "docker_container" "registry" {
  name  = "local-registry"
  image = "registry:2"

  ports {
    internal = 5000
    external = 5001
  }

  networks_advanced {
    name = docker_network.devops_network.name
  }

  restart = "always"
}

# Volume per Jenkins
resource "docker_volume" "jenkins_data" {
  name = "jenkins-data"
}

# Kontejneri Jenkins me Docker socket
resource "docker_container" "jenkins" {
  name  = "devops-jenkins"
  image = "jenkins/jenkins:lts"

  ports {
    internal = 8080
    external = 8080
  }

  ports {
    internal = 50000
    external = 50000
  }

  volumes {
    volume_name    = docker_volume.jenkins_data.name
    container_path = "/var/jenkins_home"
  }

  # Docker socket per akses te Docker i hostit
  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }

  networks_advanced {
    name = docker_network.devops_network.name
  }

  restart = "always"
}
