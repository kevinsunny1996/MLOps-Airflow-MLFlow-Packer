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
            name = "RHEL-9.0.0_HVM-*-x86_64-1-Hourly2-GP2"
            root-device-type = "ebs"
            virtualization-type = "hvm"
        }
        most_recent = true
        owners = ["309956199498"]
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