resource "aws_api_gateway_rest_api" "image-manager-api-gw" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "image-manager-api-gw"
      version = "1.0"
    }

  })

  name = "image-manager-api"
  description = "API used for ImageManagement"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_account" "image-manager-api-account" {
  cloudwatch_role_arn = aws_iam_role.api-gw-logging-role.arn

  depends_on = [aws_api_gateway_rest_api.image-manager-api-gw]
}

resource "aws_api_gateway_resource" "images" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_rest_api.image-manager-api-gw.root_resource_id
  path_part   = "images"
}

resource "aws_api_gateway_resource" "users" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_rest_api.image-manager-api-gw.root_resource_id
  path_part   = "users"
}


resource "aws_lambda_permission" "allow-api-lambda-list" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-db-listimages.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.image-manager-api-gw.execution_arn}/*"
}

resource "aws_lambda_permission" "allow-api-lambda-search" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-db-searchimageby.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.image-manager-api-gw.execution_arn}/*"
}

resource "aws_lambda_permission" "allow-api-lambda-createuser" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-db-createuser.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.image-manager-api-gw.execution_arn}/*"
}

resource "aws_lambda_permission" "allow-api-lambda-registerimage" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-db-registerimage.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.image-manager-api-gw.execution_arn}/*"
}

resource "aws_lambda_permission" "allow-api-lambda-modifyimage" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-db-modifyimage.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.image-manager-api-gw.execution_arn}/*"
}

resource "aws_lambda_permission" "allow-api-lambda-deleteimage" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-db-deleteimage.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.image-manager-api-gw.execution_arn}/*"
}

resource "aws_lambda_permission" "allow-api-lambda-login" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-cognito-login.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.image-manager-api-gw.execution_arn}/*"
}
