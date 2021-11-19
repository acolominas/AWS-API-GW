data "archive_file" "lambda-createimage" {
  type        = "zip"
  source_file = "${path.module}/source/db-createimage.py"
  output_path = "${path.module}/files/db-createimage.zip"
}

data "archive_file" "lambda-listimages" {
  type        = "zip"
  source_file = "${path.module}/source/db-listimages.py"
  output_path = "${path.module}/files/db-listimages.zip"
}

data "archive_file" "lambda-search-by" {
  type        = "zip"
  source_file = "${path.module}/source/db-searchimageby.py"
  output_path = "${path.module}/files/db-searchimageby.zip"
}

data "archive_file" "lambda-create-user" {
  type        = "zip"
  source_file = "${path.module}/source/db-createuser.py"
  output_path = "${path.module}/files/db-createuser.zip"
}

data "archive_file" "lambda-login" {
  type        = "zip"
  source_file = "${path.module}/source/db-login.py"
  output_path = "${path.module}/files/db-login.zip"
}

resource "aws_lambda_function" "lambda-db-createimage" {
  function_name = "lambda-db-createimage"
  description   = "A function to insert new image to Database"
  handler       = "db-createimage.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-createimage.zip"
  role     = aws_iam_role.lambda-user-role.arn

  environment {
    variables = {
      TABLE_NAME = "images"
    }
  }
}

resource "aws_lambda_function" "lambda-db-listimages" {
  function_name = "lambda-db-listimages"
  description   = "A function to retrieve all images from Database"
  handler       = "db-listimages.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-listimages.zip"
  role     = aws_iam_role.lambda-user-role.arn

  environment {
    variables = {
      TABLE_NAME = "images"
    }
  }
}

resource "aws_lambda_function" "lambda-db-searchimageby" {
  function_name = "lambda-db-searchimageby"
  description   = "A function to retrieve images"
  handler       = "db-searchimageby.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-searchimageby.zip"
  role     = aws_iam_role.lambda-user-role.arn

  environment {
    variables = {
      TABLE_NAME = "images"
    }
  }
}

resource "aws_lambda_function" "lambda-db-createuser" {
  function_name = "lambda-db-createuser"
  description   = "A function to insert a new user to Database"
  handler       = "db-createuser.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-createuser.zip"
  role     = aws_iam_role.lambda-user-role.arn

  environment {
    variables = {
      TABLE_NAME = "users"
    }
  }
}

resource "aws_lambda_function" "lambda-db-login" {
  function_name = "lambda-db-login"
  description   = "A function to check the user and password"
  handler       = "db-login.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-login.zip"
  role     = aws_iam_role.lambda-user-role.arn

  environment {
    variables = {
      TABLE_NAME = "users"
    }
  }
}
