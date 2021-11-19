import json
import boto3
import os

from boto3.dynamodb.conditions import Attr

dynamodb = boto3.resource('dynamodb')

table_name = os.environ['TABLE_NAME']

def lambda_handler(event, context):
    table = dynamodb.Table(table_name)

    data = table.scan(
    )

    return data['Items']
