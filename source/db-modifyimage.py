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

def delete_image_s3(id):
    image = table.scan(
        FilterExpression=Attr('id').eq(value)
        )
    filename = image['Items'][0]
    resp = s3.delete_object(Bucket=bucketS3, Key=filename)

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
            'filename': filename
        }
    )

def lambda_handler(event, context):
    image = event['image']
    table_name = os.environ['TABLE_NAME']

    for field in ["id","title", "description", "keywords","author","creator","capture_date","filename"]:
        if not event.get(field):
            return {
                'status': 'fail',
                'msg': f"{field} is not present"
            }

        id    = event['id']
        title = event['title']
        description= event['description']
        keywords= event['keywords']
        author= event['author']
        creator = event['creator']
        capture_date = event['capture_date']
        filename = event['filename']

    if event['image_content'] != "":
        delete_image_s3(id)
        filename = store_image_s3(image,id)

    store_image_dynamodb(id,title,description,keywords,author,creator,capture_date,storage_date,filename)

    response = {
      'statusCode': 200,
      'body': json.dumps(response),
      'headers': {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
    }

    return response
