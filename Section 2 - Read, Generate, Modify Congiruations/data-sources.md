## This snippet is from the Data Sources video.

### data-source.tf

```sh

provider "aws" {
  region     = "ap-southeast-1"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "instance-1" {
    ami = data.aws_ami.app_ami.id
   instance_type = "t2.micro"
}
```

### More info
In the [aws_describe_images](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html)
```
--filters "Name=name<Key name and MUST be in lowercase>,Values=amzn2-ami-hvm*<Key value>"
```
