resource "aws_api_gateway_resource" "create-user" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.users.id
  path_part   = "createUser"
}

resource "aws_api_gateway_method" "create-user" {
  rest_api_id   = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id   = aws_api_gateway_resource.create-user.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_resource" "login" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.users.id
  path_part   = "login"
}

#resource "aws_api_gateway_method" "login" {
#  rest_api_id   = aws_api_gateway_rest_api.image-manager-api-gw.id
#  resource_id   = aws_api_gateway_resource.login.id
#  http_method   = "POST"
#  authorization = "AWS_IAM"
#}


resource "aws_api_gateway_integration" "integration-create-user" {
  rest_api_id             = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id             = aws_api_gateway_resource.create-user.id
  http_method             = aws_api_gateway_method.create-user.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.lambda-db-createuser.invoke_arn
}
