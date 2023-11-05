provider "aws" {
  region = "us-east-2"
}

provider "docker" {
  
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }

    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}