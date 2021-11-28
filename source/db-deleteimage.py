import json
import boto3
import os

from boto3.dynamodb.conditions import Attr,Key

dynamodb = boto3.resource('dynamodb')
s3 = boto3.client('s3')
table_name = os.environ['TABLE_NAME']
bucketS3 = os.environ['BUCKET_S3']
table = dynamodb.Table(table_name)

def delete_image_dynamodb(id):
    try:
        resp = table.delete_item( Key={ 'id': id } )
    except Exception as e:
        return None, str(e)
    return resp,None

def delete_image_s3(id):
    try:
        res = table.scan(
            FilterExpression=Attr('id').eq(id)
        )
        image = res['Items'][0]
        filename = image['filename']
        resp = s3.delete_object(Bucket=bucketS3, Key=filename)
    except Exception as e:
        return None, str(e)
    return resp, None

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
