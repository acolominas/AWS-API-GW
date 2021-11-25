import json
import boto3
import os
import base64

from boto3.dynamodb.conditions import Attr
from datetime import datetime,date

dynamodb = boto3.resource('dynamodb')
s3 = boto3.client('s3')
table_name = os.environ['TABLE_NAME']
bucketS3 = os.environ['BUCKET_S3']
region = os.environ['AWS_REGION']

def generate_unique_id():
    now = datetime.now()
    timestamp = str(int(round(datetime.timestamp(now))))
    return timestamp

def store_image_s3(image,filename,identifier):
    extension = filename.split('.')[1]
    new_filename = identifier + '.' + extension
    file_content = base64.b64decode(image)
    s3.put_object(Bucket=bucketS3, Key=new_filename, Body=file_content,ContentType='image/'+extension, ACL='public-read')
    return new_filename, None

def store_image_dynamodb(id,title,description,keywords,author,creator,capture_date,storage_date,filename):
    table = dynamodb.Table(table_name)
    table.put_item(
        Item={
            'id': id,
            'title': title,
            'description': description,
            'keywords': keywords,
            'author': author,
            'creator': creator,
            'capture_date': capture_date,
            'storage_date': storage_date,
            'filename': filename,
            'object_url': f'https://{bucketS3}.s3.{region}.amazonaws.com/{filename}'
        }
    )
    return "OK", None

def lambda_handler(event, context):

    for field in ["title", "description", "keywords","author","creator","capture_date","filename","image_content"]:
        if not event.get(field):
            return {
                'status': 'fail',
                'msg': f"{field} is not present"
            }

    title = event['title']
    description= event['description']
    keywords= event['keywords']
    author= event['author']
    creator = event['creator']
    capture_date = event['capture_date']
    filename = event['filename']
    image = event['image_content']

    identifier = generate_unique_id()
    storage_date = str(date.today())

    new_filename, msg = store_image_s3(image,filename,identifier)

    if msg != None:
        return {
            'status': 'fail',
            'msg': msg
        }

    resp, msg = store_image_dynamodb(identifier,title,description,keywords,author,creator,capture_date,storage_date,new_filename)

    if msg != None:
        return {
            'status': 'fail',
            'msg': msg
        }

    response = {
      'statusCode': 200,
      'body': json.dumps("Image register"),
      'headers': {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    }

    return response
