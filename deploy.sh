sam build
sam package --output-template-file packaged.yaml --s3-bucket sam-serverless-demo-lambda
sam deploy --template-file packaged.yaml --stack-name sam-demo-develop --s3-bucket sam-serverless-demo-lambda --capabilities CAPABILITY_IAM --region eu-west-1 --parameter-overrides DomainName=develop.api.demo.cloudlabs.link
