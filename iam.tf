resource "aws_iam_role" "lambda-user-role" {
  name = "iam_for_lambda"

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

resource "aws_iam_policy" "lambda-policy" {
  name        = "transfer-lambda-user-policy"
  path        = "/"
  description = "Lambda Policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "dynamodb:*"
            ],
            "Resource": "arn:aws:dynamodb:eu-west-1:004914726163:table/images",
            "Effect": "Allow"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "lambda-attach-1" {
  name       = "test-attachment-1"
  roles      = [aws_iam_role.lambda-user-role.name]
  policy_arn = aws_iam_policy.lambda-policy.arn
}

resource "aws_iam_role" "api-gw-logging-role" {
  name = "api-gw-logging-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "api-gw-logging-policy" {
  name = "api-gw-logging-policy"
  role = aws_iam_role.api-gw-logging-role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:FilterLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "image-manager-api-role" {
  name = "image-manager-api-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "transfer.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "image-manager-api-policy" {
  name = "image-manager-api-policy"
  role = aws_iam_role.image-manager-api-role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Action": [
            "execute-api:Invoke"
          ],
          "Resource": "${aws_api_gateway_rest_api.image-manager-api-gw.execution_arn}/prod/GET/*",
          "Effect": "Allow"
        },
        {
          "Action": [
            "apigateway:GET"
          ],
          "Resource": "*",
          "Effect": "Allow"
        }
    ]
}
EOF
}
