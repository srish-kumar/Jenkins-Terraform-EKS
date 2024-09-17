terraform {
  required_version = "~> 1.9.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
    }
  }
  backend "s3" {
    bucket         = "sri-eks-s3backet-156461"
    region         = "us-east-1"
    key            = "eks/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "Lock-Files"
  }
}

provider "aws" {
  region = var.aws-region
}

