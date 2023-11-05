resource "docker_image" "keycloak" {
  name         = "quay.io/keycloak/keycloak:20.0.2"
  keep_locally = false
}

resource "docker_container" "keycloak" {
  image = docker_image.keycloak.image_id
  name  = "lanchonete_keycloak"
  must_run = true
  command = [
    "run",
    "quay.io/keycloak/keycloak",
    "start-dev"
  ]
  ports {
    internal = 8080
    external = 8081
  }
}



# resource "docker_image" "nginx" {
#   name         = "nginx:latest"
#   keep_locally = false
# }

# resource "docker_container" "nginx" {
#   image = docker_image.nginx.image_id
#   name  = "tutorial"
#   ports {
#     internal = 80
#     external = 8000
#   }
# }