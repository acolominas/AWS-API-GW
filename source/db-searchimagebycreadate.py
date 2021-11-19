import json
import boto3
import os

from boto3.dynamodb.conditions import Attr

dynamodb = boto3.resource('dynamodb')
table_name = os.environ['TABLE_NAME']

def lambda_handler(event, context):
    table = dynamodb.Table(table_name)
    date = event['pathParameters']['date']

    data = table.scan(
      FilterExpression=Attr('storage_date').eq(date)
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
