output "server-public-ip" {
  value = "Server Public IP: ${module.app-server.instance.public_ip}"
}