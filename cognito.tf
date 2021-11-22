resource "aws_cognito_user_pool_domain" "users-image-domain" {
  domain       = "image-manager"
  user_pool_id = aws_cognito_user_pool.users-image-pool.id
}

resource "aws_cognito_user_pool" "users-image-pool" {
  name = "users-image-pool"
}

resource "aws_cognito_user_pool_client" "image-manager-client" {
    name = "image-manager-client"
    user_pool_id = aws_cognito_user_pool.users-image-pool.id
    explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH","ALLOW_REFRESH_TOKEN_AUTH"]

    generate_secret     = true
    #callback_urls = ["www.google.com"]

}

resource "aws_cognito_identity_pool" "image-manager-identity" {
  identity_pool_name               = "image-manager-identity"
  allow_unauthenticated_identities = false
  allow_classic_flow               = false

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.image-manager-client.id
    provider_name           = "cognito-idp.us-east-1.amazonaws.com/${aws_cognito_user_pool.users-image-pool.id}"
    server_side_token_check = false
  }
}
