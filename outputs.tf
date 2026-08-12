output "public_ip" {
    description = "Webserver's public IP address"
    value = aws_instance.web_server.public_ip
}

output "web_url" {
    description = "URL address of the page"
    value = "http://${aws_instance.web_server.public_ip}"
}