resource "aws_api_gateway_resource" "search-by-id" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.images.id
  path_part   = "searchID"
}

resource "aws_api_gateway_resource" "image-id" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.search-by-id.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "search-by-id" {
  rest_api_id   = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id   = aws_api_gateway_resource.image-id.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration-search-by-id" {
  rest_api_id             = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id             = aws_api_gateway_resource.image-id.id
  http_method             = aws_api_gateway_method.search-by-id.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-db-searchimagebyid.invoke_arn
}

##########SEARCH BY AUTHOR

resource "aws_api_gateway_resource" "search-by-author" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.images.id
  path_part   = "searchAuthor"
}

resource "aws_api_gateway_resource" "image-author" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.search-by-author.id
  path_part   = "{author}"
}

resource "aws_api_gateway_method" "search-by-author" {
  rest_api_id   = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id   = aws_api_gateway_resource.image-author.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration-search-by-author" {
  rest_api_id             = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id             = aws_api_gateway_resource.image-author.id
  http_method             = aws_api_gateway_method.search-by-author.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-db-searchimagebyauthor.invoke_arn
}

##########SEARCH BY TITLE

resource "aws_api_gateway_resource" "search-by-title" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.images.id
  path_part   = "searchTitle"
}

resource "aws_api_gateway_resource" "image-title" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.search-by-title.id
  path_part   = "{title}"
}

resource "aws_api_gateway_method" "search-by-title" {
  rest_api_id   = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id   = aws_api_gateway_resource.image-title.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration-search-by-title" {
  rest_api_id             = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id             = aws_api_gateway_resource.image-title.id
  http_method             = aws_api_gateway_method.search-by-title.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-db-searchimagebytitle.invoke_arn
}

##########SEARCH BY CREATIONDATE

resource "aws_api_gateway_resource" "search-by-creadate" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.images.id
  path_part   = "searchCreationDate"
}

resource "aws_api_gateway_resource" "image-creadate" {
  rest_api_id = aws_api_gateway_rest_api.image-manager-api-gw.id
  parent_id   = aws_api_gateway_resource.search-by-creadate.id
  path_part   = "{date}"
}

resource "aws_api_gateway_method" "search-by-creadate" {
  rest_api_id   = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id   = aws_api_gateway_resource.image-creadate.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration-search-by-creadate" {
  rest_api_id             = aws_api_gateway_rest_api.image-manager-api-gw.id
  resource_id             = aws_api_gateway_resource.image-creadate.id
  http_method             = aws_api_gateway_method.search-by-creadate.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-db-searchimagebycreadate.invoke_arn
}
