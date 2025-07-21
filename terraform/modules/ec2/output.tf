output "ec2-one-ip" {
  value = aws_instance.myAppone.public_ip
}

output "ec2-two-ip" {
  value = aws_instance.myAppTwo.public_ip
}