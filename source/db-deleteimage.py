import json
import boto3
import os

from boto3.dynamodb.conditions import Attr

dynamodb = boto3.resource('dynamodb')
s3 = boto3.client('s3')
table_name = os.environ['TABLE_NAME']
bucketS3 = os.environ['BUCKET_S3']
table = dynamodb.Table(table_name)


def delete_image_dynamodb(id):
    resp = table.delete_item( Key={ 'id': id } )

def delete_image_s3(id):
    image = table.scan(
        FilterExpression=Attr('id').eq(value)
        )
    filename = image['Items'][0]
    resp = s3.delete_object(Bucket=bucketS3, Key=filename)

def lambda_handler(event, context):

    if not event.get('id'):
        return {
            'status': 'fail',
            'msg': "id is not present"
        }

    id = event['id']

    resp, msg = delete_image_s3(id)
    if resp != None:
        resp, msg = delete_image_dynamodb(id)

    if msg != None:
        response = {
            'status': 'fail',
            'msg': msg
        }
    else:
        response = {
            'status': 'success',
            'msg': "Image deleted!"
        }

    return response
