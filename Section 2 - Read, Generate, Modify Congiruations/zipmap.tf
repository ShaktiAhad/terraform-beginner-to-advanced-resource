### using count
provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

zipmap(["pineapple","oranges","strawberry"], ["yellow","orange","red"])

resource "aws_iam_user" "lb" {
  name = "demo-user.${count.index}"
  count = 3
  path = "/system/"
}

output "arns" {
  value = aws_iam_user.lb[*].arn
}

output "zipmap" {
  value = zipmap(aws_iam_user.lb[*].name, aws_iam_user.lb[*].arn)
}


### using for_each [https://developer.hashicorp.com/terraform/language/functions/values]
resource "aws_iam_user" "iam_users" {
  for_each = toset(var.iam_user_list)
  name = each.key

  tags = {
    tag-key = "${each.key}_tf_iam_user"
  }
}
output "iam_users_arn" {
  value = zipmap(values(aws_iam_user.iam_users)[*].name, values(aws_iam_user.iam_users)[*].arn)
}
