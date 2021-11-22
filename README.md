# api-rest-aws

Serverless API REST builded with API Gateway Service to store images to s3 and manage it.

![Alt text](readme_files/api-rest.drawio.png?raw=true "Title")

To add security to API, we will use Cognito service to authenticate & authorize the access to the API methods using OAuth 2 protocol.

All API methods ara developed in Python using lambdas.

Physical images are stored in S3 Bucket and its metadata is stored in a DynamoDB table. The images stored are public and publicated.

### AWS Services Involved

* API Gateway
* Lambda
* S3
* DynamoDB
* Cognito

### TODO
* Federate authentication with other identity providers like Facebook,Google...
* Use CloudFront with S3 bucket
