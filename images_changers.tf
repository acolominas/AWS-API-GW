###REGISTER

resource "aws_api_gateway_method" "register-image" {
  rest_api_id   = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id   = aws_api_gateway_resource.images.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.api-authorizer-cognito.id
}

resource "aws_api_gateway_integration" "integration-register-image" {
  rest_api_id             = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id             = aws_api_gateway_resource.images.id
  http_method             = aws_api_gateway_method.register-image.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.lambda-db-registerimage.invoke_arn
}

resource "aws_api_gateway_method_response" "response_200-register-image" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id = aws_api_gateway_resource.images.id
  http_method = aws_api_gateway_method.register-image.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "register-image-integration-response" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id = aws_api_gateway_resource.images.id
  http_method = aws_api_gateway_method.register-image.http_method
  status_code = aws_api_gateway_method_response.response_200-register-image.status_code

  depends_on = [aws_api_gateway_integration.integration-register-image]
}


###MODIFY

resource "aws_api_gateway_method" "modify-image" {
  rest_api_id   = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id   = aws_api_gateway_resource.images.id
  http_method   = "PUT"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.api-authorizer-cognito.id
}

resource "aws_api_gateway_integration" "integration-modify-image" {
  rest_api_id             = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id             = aws_api_gateway_resource.images.id
  http_method             = aws_api_gateway_method.modify-image.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.lambda-db-modifyimage.invoke_arn
}

resource "aws_api_gateway_method_response" "response_200-modify-image" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id = aws_api_gateway_resource.images.id
  http_method = aws_api_gateway_method.modify-image.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "modify-image-integration-response" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id = aws_api_gateway_resource.images.id
  http_method = aws_api_gateway_method.modify-image.http_method
  status_code = aws_api_gateway_method_response.response_200-modify-image.status_code

  depends_on = [aws_api_gateway_integration.integration-modify-image]
}

###DELETE

resource "aws_api_gateway_method" "delete-image" {
  rest_api_id   = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id   = aws_api_gateway_resource.images.id
  http_method   = "DELETE"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.api-authorizer-cognito.id
}

resource "aws_api_gateway_integration" "integration-delete-image" {
  rest_api_id             = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id             = aws_api_gateway_resource.images.id
  http_method             = aws_api_gateway_method.delete-image.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.lambda-db-deleteimage.invoke_arn
}

resource "aws_api_gateway_method_response" "response_200-delete-image" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id = aws_api_gateway_resource.images.id
  http_method = aws_api_gateway_method.delete-image.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "delete-image-integration-response" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id = aws_api_gateway_resource.images.id
  http_method = aws_api_gateway_method.delete-image.http_method
  status_code = aws_api_gateway_method_response.response_200-delete-image.status_code

  depends_on = [aws_api_gateway_integration.integration-delete-image]
}
