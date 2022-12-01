packer {
    required_plugins {
        amazon = {
            version = ">= 0.0.2"
            source = "github.com/hashicorp/amazon"
        }
    }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "mlflow" {
    ami_name = "mlflow-server-${local.timestamp}"
    instance_type = "t2.micro"
    region = "us-east-1"

    source_ami_filter {
        filters = {
            name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
            root-device-type = "ebs"
            virtualization-type = "hvm"
        }
        most_recent = true
        owners = ["099720109477"]
    }
    ssh_username = "ubuntu"
}

build {
    name = "MLFLow-AMI"

    sources = [
        "source.amazon-ebs.mlflow"
    ]

    provisioner "shell" {
        script = "./setup/mlflow_setup.sh"
    }
}