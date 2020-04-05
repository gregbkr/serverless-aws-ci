# Serverless Framework: Lambda + API in codepipeline in AWS

## Overview
CodePipeline will create 2 Lambda apps (javascript + python3) and get a domain url via Apigateway + route53, using serverless

I used this [tuto](https://docs.gitlab.com/ee/user/project/clusters/serverless/aws.html#serverless-framework).


## Deploy

### Requisit

- Optional: create a certificate for this API e.g.: `*.api.demo.cloudlabs.link`
- You can create a new serverless template with : `serverless create --template aws-nodejs`
- First create the IAM user with: 
```
cd terraform
nano main.tf <-- edit with your needs
terraform init
terraform apply
```
- You will get the value from the output.


### Deploy manually
Deploy with: `serverless deploy --stage production --verbose`


To deploy to all component another environment, in DEV, change the `stack-name` user:

Test with your own URL and API key (you will find the key in aws console apigateway -> apikeys): 
```
curl -H "x-api-key: nM89m9UsGv4SoxntuILms5wcghkREYvY25g77CtB" https://a18qribs8i.execute-api.eu-west-1.amazonaws.com/Prod/hello/
{"message": "hello world"}%
```

### Deploy via CI
- Edit ci with your needs: `nano .gitlab-ci.yml`
- Push file

### Deploy/test locally
```
serverless offline
curl http://localhost:3000/dev/hellojs
```

### Check values
aws cloudformation describe-stacks --stack-name gitlabpoc --region eu-west-1 \
    --query 'Stacks[0].Outputs[?OutputKey==`ServerlessApiKey`].OutputValue' \
    --output text

## Destroy all
- Destroy using the right region: `aws cloudformation delete-stack --stack-name sam-demo-develop --region eu-west-1`

Todo:
- [x] Secure with APIkey
- [x] Dev + Prod
- [x] Ci create + delete stack
- [x] Add route53 domain + Cert
  