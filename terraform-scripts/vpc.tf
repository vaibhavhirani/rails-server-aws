resource "aws_vpc" "rails_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "rails_subnet" {
  vpc_id     = aws_vpc.rails_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "rails"
  }
}