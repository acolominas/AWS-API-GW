import json
import boto3
import os

from boto3.dynamodb.conditions import Attr

dynamodb = boto3.resource('dynamodb')
s3 = boto3.client('s3')
table_name = os.environ['TABLE_NAME']
bucketS3 = os.environ['BUCKET_S3']

def delete_image_s3(filename):
    s3.delete_object(Bucket=bucketS3, Key=filename)


def lambda_handler(event, context):
    id = event['id']
    table = dynamodb.Table(table_name)

    image = table.scan(
        FilterExpression=Attr('id').eq(value)
    )
    image = image['Items'][0]

    delete_image_s3(image["filename"])

    table.delete_item(
        Key={   'id': id
            }
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
