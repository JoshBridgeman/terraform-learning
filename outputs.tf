output "latest-img" {
  value = "Image fetched: ${data.aws_ami.latest-amazon-linux-image.name} (${data.aws_ami.latest-amazon-linux-image.id})"
}
output "server-public-ip" {
  value = "Server Public IP: ${aws_instance.app-server.public_ip}"
}