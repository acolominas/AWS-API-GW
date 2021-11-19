resource "aws_api_gateway_resource" "search-by" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.images.id
  path_part   = "search"
}

resource "aws_api_gateway_resource" "image-key" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.search-by.id
  path_part   = "{key}"
}

resource "aws_api_gateway_resource" "image-value" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.image-key.id
  path_part   = "{value}"
}

resource "aws_api_gateway_method" "search-by" {
  rest_api_id   = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id   = aws_api_gateway_resource.image-value.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration-search-by-id" {
  rest_api_id             = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id             = aws_api_gateway_resource.image-value.id
  http_method             = aws_api_gateway_method.search-by.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-db-searchimageby.invoke_arn
}
