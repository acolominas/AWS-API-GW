import json
import boto3
import os
import base64

from boto3.dynamodb.conditions import Attr
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
s3 = boto3.client('s3')
table_name = os.environ['TABLE_NAME']
bucketS3 = os.environ['BUCKET_S3']

def store_image_s3(image,identifier):
    extension = image['filename'].split('.')[1]
    new_filename = identifier + '.' + extension
    file_content = base64.b64decode(image['image_content'])
    s3.put_object(Bucket=bucketS3, Key=new_filename, Body=file_content)
    return new_filename

def generate_unique_id():
    now = datetime.now()
    timestamp = str(int(round(datetime.timestamp(now))))
    return timestamp


def lambda_handler(event, context):
    image = event['image']

    identifier = generate_unique_id()

    table = dynamodb.Table(table_name)

    new_filename = store_image_s3(image,identifier)

    image['id'] = identifier
    image['filename'] = new_filename
    image['image_content'] = ""

    table.put_item(
        Item=image
    )

    response = {
      'statusCode': 200,
      'body': json.dumps("Image register"),
      'headers': {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    }

    return response
