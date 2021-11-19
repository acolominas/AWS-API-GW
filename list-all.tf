resource "aws_api_gateway_resource" "list-all" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.images.id
  path_part   = "list"
}

resource "aws_api_gateway_method" "list-all" {
  rest_api_id   = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id   = aws_api_gateway_resource.list-all.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration-list-all" {
  rest_api_id             = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id             = aws_api_gateway_resource.list-all.id
  http_method             = aws_api_gateway_method.list-all.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.lambda-db-listimages.invoke_arn
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id = aws_api_gateway_resource.list-all.id
  http_method = aws_api_gateway_method.list-all.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "image-api-integration-response" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id = aws_api_gateway_resource.list-all.id
  http_method = aws_api_gateway_method.list-all.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  #depends_on = [aws_api_gateway_integration.integration-list-all]
}
