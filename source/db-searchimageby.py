import json
import boto3
import os

from boto3.dynamodb.conditions import Attr

dynamodb = boto3.resource('dynamodb')
table_name = os.environ['TABLE_NAME']

def lambda_handler(event, context):
    table = dynamodb.Table(table_name)
    key= event['pathParameters']['key']
    value= event['pathParameters']['value']
    data = "";
    if key == "title" or key == "author" or key == "keywords":
            data = table.scan(
            FilterExpression=Attr(key).contains(value)
        )
    elif key == "creationdate":
        data = table.scan(
            FilterExpression=Attr("storage_date").contains(value)
        )
    elif key == "id":
        data = table.scan(
            FilterExpression=Attr(key).eq(value)
        )

    response = {
      'statusCode': 200,
      'body': json.dumps(data),
      'headers': {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    }

    return response
