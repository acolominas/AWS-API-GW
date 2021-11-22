import json
import boto3
import os


from boto3.dynamodb.conditions import Attr

dynamodb = boto3.resource('dynamodb')

def store_image_s3(image,identifier):
    extension = image['filename'].split('.')[1]
    new_filename = identifier + '.' + extension
    file_content = base64.b64decode(image['image_content'])
    s3.put_object(Bucket=bucketS3, Key=new_filename, Body=file_content,ContentType='image/'+extension, ACL='public-read')
    return new_filename

def delete_image_s3(filename):
    s3.delete_object(Bucket=bucketS3, Key=filename)

def lambda_handler(event, context):
    image = event['image']
    table_name = os.environ['TABLE_NAME']
    table = dynamodb.Table(table_name)

    if image['image_content'] != "":
        delete_image_s3(image['filename'])
        new_filename = store_image_s3(image,image['id'])
        image['filename'] = new_filename
        image['image_content'] = ""

    table.put_item(
        Item=image
    )

    response = {
      'statusCode': 200,
      'body': json.dumps(response),
      'headers': {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
    }

    return response
