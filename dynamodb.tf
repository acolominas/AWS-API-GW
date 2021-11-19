resource "aws_dynamodb_table" "images-table" {
  name           = "images"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "user-tables" {
  name           = "users"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "username"

  attribute {
    name = "username"
    type = "S"
  }
}
