## Data Sources para obtener ID de la VPC Default

data "aws_vpc" "default" {
  default = true
}

## Data Sources para obtener ID de la subnet zona A
data "aws_subnet" "zona_c" {
  availability_zone = "us-east-1c"
}

data "aws_subnet" "zona_f" {
  availability_zone = "us-east-1f"
}