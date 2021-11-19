data "archive_file" "lambda-registerimage" {
  type        = "zip"
  source_file = "${path.module}/source/db-registerimage.py"
  output_path = "${path.module}/files/db-registerimage.zip"
}

data "archive_file" "lambda-modifyimage" {
  type        = "zip"
  source_file = "${path.module}/source/db-modifyimage.py"
  output_path = "${path.module}/files/db-modifyimage.zip"
}

data "archive_file" "lambda-deleteimage" {
  type        = "zip"
  source_file = "${path.module}/source/db-deleteimage.py"
  output_path = "${path.module}/files/db-deleteimage.zip"
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

resource "aws_lambda_function" "lambda-db-registerimage" {
  function_name = "lambda-db-registerimage"
  description   = "A function to insert new image to Database"
  handler       = "db-registerimage.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-registerimage.zip"
  role     = aws_iam_role.lambda-image-role.arn

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.images-table.name
    }
  }
}

resource "aws_lambda_function" "lambda-db-modifyimage" {
  function_name = "lambda-db-modifyimage"
  description   = "A function to modify an existing image in Database"
  handler       = "db-modifyimage.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-modifyimage.zip"
  role     = aws_iam_role.lambda-image-role.arn

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.images-table.name
    }
  }
}

resource "aws_lambda_function" "lambda-db-deleteimage" {
  function_name = "lambda-db-deleteimage"
  description   = "A function to delete an existing image in Database"
  handler       = "db-deleteimage.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-deleteimage.zip"
  role     = aws_iam_role.lambda-image-role.arn

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.images-table.name
    }
  }
}

resource "aws_lambda_function" "lambda-db-listimages" {
  function_name = "lambda-db-listimages"
  description   = "A function to retrieve all images from Database"
  handler       = "db-listimages.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-listimages.zip"
  role     = aws_iam_role.lambda-image-role.arn

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.images-table.name
    }
  }
}

resource "aws_lambda_function" "lambda-db-searchimageby" {
  function_name = "lambda-db-searchimageby"
  description   = "A function to retrieve images using key/value"
  handler       = "db-searchimageby.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-searchimageby.zip"
  role     = aws_iam_role.lambda-image-role.arn

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.images-table.name
    }
  }
}

resource "aws_lambda_function" "lambda-db-createuser" {
  function_name = "lambda-db-createuser"
  description   = "A function to insert a new user to Database"
  handler       = "db-createuser.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-createuser.zip"
  role     = aws_iam_role.lambda-image-role.arn

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.users-table.name
    }
  }
}

resource "aws_lambda_function" "lambda-db-login" {
  function_name = "lambda-db-login"
  description   = "A function to check user and password"
  handler       = "db-login.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-login.zip"
  role     = aws_iam_role.lambda-image-role.arn

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.users-table.name
    }
  }
}
