resource "aws_lambda_function" "demo" {
  filename         = var.package
  function_name    = "${var.app_id}-${var.app_env}"
  runtime          = "nodejs16.x"
  timeout          = 10
  publish          = true
  handler          = "index.handler"
  source_code_hash = filesha256("${var.package}")
  role             = aws_iam_role.lambda_role.arn

  environment {
    variables = {
      foo = "bar"
    }
  }
  tags = {
    "project" = "demo"
    "infra"   = "terraform"
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.app_id}-${var.app_env}-Role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

