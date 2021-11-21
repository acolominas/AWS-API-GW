resource "aws_iam_role" "lambda-image-role" {
  name = "lambda-image-role"

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

resource "aws_iam_policy" "lambda-image-policy" {
  name        = "lambda-image-policy"
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
            "Resource": [
                "${aws_dynamodb_table.users-table.arn}",
                "${aws_dynamodb_table.images-table.arn}"
            ],
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
        },
        {
        "Effect" : "Allow",
            "Action" : [
                "s3:*"
            ],
            "Resource" : [
               "${aws_s3_bucket.images-bucket.arn}",
               "${aws_s3_bucket.images-bucket.arn}/*"
            ]
        },
        {
        "Effect" : "Allow",
            "Action" : [
                "kms:Decrypt"
                ],
            "Resource" : [
              "*"
              ]
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "lambda-attach-1" {
  name       = "test-attachment-1"
  roles      = [aws_iam_role.lambda-image-role.name]
  policy_arn = aws_iam_policy.lambda-image-policy.arn
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
