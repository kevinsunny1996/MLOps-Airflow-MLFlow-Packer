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
    ami_name = "mlflow-server-{local.timestamp}"
    instance_type = "t2.micro"
    region = "us-east-1"

    source_ami_filter {
        filters = {
            name = "amzn2-ami-kernel-5.10-hvm-2.*-x86_64-gp2"
            root-device-type = "ebs"
            virtualization-type = "hvm"
        }
        most_recent = true
        owners = ["137112412989"]
    }
    ssh_username = "ec2-user"
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