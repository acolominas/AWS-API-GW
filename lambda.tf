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

data "archive_file" "lambda-search-title" {
  type        = "zip"
  source_file = "${path.module}/source/db-searchimagebytitle.py"
  output_path = "${path.module}/files/db-searchimagebytitle.zip"
}

data "archive_file" "lambda-search-id" {
  type        = "zip"
  source_file = "${path.module}/source/db-searchimagebyid.py"
  output_path = "${path.module}/files/db-searchimagebyid.zip"
}

data "archive_file" "lambda-search-author" {
  type        = "zip"
  source_file = "${path.module}/source/db-searchimagebyauthor.py"
  output_path = "${path.module}/files/db-searchimagebyauthor.zip"
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

data "archive_file" "lambda-search-creadate" {
  type        = "zip"
  source_file = "${path.module}/source/db-searchimagebycreadate.py"
  output_path = "${path.module}/files/db-searchimagebycreadate.zip"
}


resource "aws_lambda_function" "lambda-db-createimage" {
  function_name = "lambda-db-createimage"
  description   = "A function to lookup and return user data from AWS Secrets Manager."
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
  description   = "A function to lookup and return user data from AWS Secrets Manager."
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

resource "aws_lambda_function" "lambda-db-searchimagebytitle" {
  function_name = "lambda-db-searchimagebytitle"
  description   = "A function to lookup and return user data from AWS Secrets Manager."
  handler       = "db-searchimagebytitle.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-searchimagebytitle.zip"
  role     = aws_iam_role.lambda-user-role.arn

  environment {
    variables = {
      TABLE_NAME = "images"
    }
  }
}

resource "aws_lambda_function" "lambda-db-searchimagebyid" {
  function_name = "lambda-db-searchimagebyid"
  description   = "A function to lookup and return user data from AWS Secrets Manager."
  handler       = "db-searchimagebyid.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-searchimagebyid.zip"
  role     = aws_iam_role.lambda-user-role.arn

  environment {
    variables = {
      TABLE_NAME = "images"
    }
  }
}

resource "aws_lambda_function" "lambda-db-searchimagebyauthor" {
  function_name = "lambda-db-searchimagebyauthor"
  description   = "A function to lookup and return user data from AWS Secrets Manager."
  handler       = "db-searchimagebyauthor.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-searchimagebyauthor.zip"
  role     = aws_iam_role.lambda-user-role.arn

  environment {
    variables = {
      TABLE_NAME = "images"
    }
  }
}

resource "aws_lambda_function" "lambda-db-searchimagebycreadate" {
  function_name = "lambda-db-searchimagebycreadate"
  description   = "A function to lookup and return user data from AWS Secrets Manager."
  handler       = "db-searchimagebycreadate.lambda_handler"
  runtime       = "python3.9"

  filename = "${path.module}/files/db-searchimagebycreadate.zip"
  role     = aws_iam_role.lambda-user-role.arn

  environment {
    variables = {
      TABLE_NAME = "images"
    }
  }
}

resource "aws_lambda_function" "lambda-db-createuser" {
  function_name = "lambda-db-createuser"
  description   = "A function to lookup and return user data from AWS Secrets Manager."
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
  description   = "A function to lookup and return user data from AWS Secrets Manager."
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
