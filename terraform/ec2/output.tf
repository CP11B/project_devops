output "jenkins_ip" {
  value = aws_instance.jenkins.public_ip
}
output "production_ip" {
  value = aws_instance.production.public_ip
}
output "test_ip" {
  value = aws_instance.test.public_ip
}