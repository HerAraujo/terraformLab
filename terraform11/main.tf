provider "aws" { #aws
  region = "us-east-1" #norte de virginia
  access_key = ""
  secret_key = ""
}

## AWS S3 -> bucket S3 -> Almacenamiento de Objetos

resource "aws_s3_bucket" "demos3" {
  bucket = "demo-bootcamp-aws-s3"
  acl    = "private"   #publico/privado

  versioning {
    enabled = true
  }
}