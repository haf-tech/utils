# Terraform
# basic example

# Create an EC2 instance
resource "null_resource" "example" {
  
  provisioner "local-exec" {
    command = "echo $(date -u +'%Y-%m-%dT%H:%M:%SZ')"
  }
}

