import boto3
import hmac
import hashlib
import base64
import os

USER_POOL_ID = os.environ['USER_POOL_ID']
CLIENT_ID = os.environ['CLIENT_ID']
CLIENT_SECRET = os.environ['CLIENT_SECRET']

client = None

def get_secret_hash(username):
    msg = username + CLIENT_ID
    digest = hmac.new(str(CLIENT_SECRET).encode('utf-8'), msg=str(msg).encode('utf-8'), digestmod=hashlib.sha256).digest()
    dec = base64.b64encode(digest).decode()
    return dec

def initiate_signup(username, password, email):
    try:
        resp = client.sign_up(
            ClientId=CLIENT_ID,
            SecretHash=get_secret_hash(username),
            Username=username,
            Password=password,

            UserAttributes=[
                { 'Name': "email",'Value': email }
            ],
            ValidationData=[
                {'Name': "email", 'Value': email},
                {'Name': "custom:username",'Value': username}
            ])

    except client.exceptions.UsernameExistsException as e:
        return None, "This username already exists"
    except client.exceptions.InvalidPasswordException as e:
        return None, "Password should have Caps, Special chars, Numbers",
    except client.exceptions.UserLambdaValidationException as e:
        return None, "Email already exists"
    except Exception as e:
        return None, str(e)
    return resp, None

def initiate_confirmation(username):
    try:
        resp = client.admin_confirm_sign_up(
            UserPoolId=USER_POOL_ID,
            Username=username
        )
    except Exception as e:
        return None, str(e)
    return resp, None

def lambda_handler(event, context):
    global client
    if client == None:
        client = boto3.client('cognito-idp')

    for field in ["username", "email", "password"]:
        if not event.get(field):
            return {
                'status': 'fail',
                'msg': f"{field} is not present"
            }

    username = event['username']
    password = event['password']
    email    =  event['email']

    resp, msg = initiate_signup(username, password, email)

    if msg != None:
        return {
            'status': 'fail',
            'msg': msg
        }
    resp, msg = initiate_confirmation(username)

    if msg != None:
        return {
            'status': 'fail',
            'msg': msg
        }

    response = {
        'status': 'success',
        'msg': "User created!"
    }
    return response

    resp, msg = initiate_signup(username, password, email)

    if msg != None:
        return {
            'status': 'fail',
            'msg': msg
        }

    response = {
        'status': 'success',
        'msg': "User created! Please confirm your signup, check Email for validation code"
    }
    return response
