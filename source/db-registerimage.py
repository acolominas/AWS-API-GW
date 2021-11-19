import json
import boto3
import os

from boto3.dynamodb.conditions import Attr

dynamodb = boto3.resource('dynamodb')
table_name = os.environ['TABLE_NAME']

def lambda_handler(event, context):
    image = event['image']
    print(image)

    table = dynamodb.Table(table_name)

    table.put_item(
        Item=image
    )

    response = {
      'statusCode': 200,
      'body': json.dumps("Image register"),
      'headers': {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
    }

    return response
