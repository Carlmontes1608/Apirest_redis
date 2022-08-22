variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}

provider "aws" {
    profile    = "default"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region="us-east-1"
}

resource "aws_instance" "docker_reto" {
    ami           =        lookup(var.image, var.selectami)
    instance_type =        "${var.instancetype}"
    security_groups =      ["${aws_security_group.docker.name}"]
    key_name        =       "my_second"
    user_data       =      "${file("./install_ubunt.sh")}"
    tags = {
     Name = "EC2-with-Docker-Compose-App"
    
    }

connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("C:/Users/Facus/.ssh/id_rsa/my_keys")
      timeout     = "4m"
   }

    ebs_block_device {
        device_name = "sda2"
        volume_size = 16
        encrypted   = true
    }

}

output "Instance_ip" {
    value = aws_instance.docker_reto.public_ip
}
