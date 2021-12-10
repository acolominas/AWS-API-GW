# api-rest-aws-testing

Serverless API REST built with API Gateway Service to store images and manage it.

![Alt text](readme_files/api-rest.drawio.jpg?raw=true "Title")

To add security to the API, we will use the Cognito service to authenticate and authorize access to the API methods using the OAuth 2 protocol.

All API methods have been developed in Python using AWS Lambdas.

Physical images are stored in S3 and their metadata is stored in a DynamoDB table. The stored images are published through Cloudfront.

### AWS Services Involved

* Amazon API Gateway
* AWS Lambda
* Amazon S3
* Amazon DynamoDB
* Amazon Cognito
* AWS IAM
* Amazon CloudFront

### TODO
* Federate authentication with other identity providers like Facebook,Google...
