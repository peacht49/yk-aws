
# provider is the plugin for infra, terraform init looks at this and runs binary

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
}
}

provider "aws" {
  region = "ap-southeast-1"
}