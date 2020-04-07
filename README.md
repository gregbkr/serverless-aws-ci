# Serverless Framework: Lambda + API in codebuild in AWS

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
- Deploy with: `sls deploy --stage dev --verbose`
- Deploy to prod: `sls deploy --stage prod --verbose`

To deploy to all component another environment, in DEV, change the `stack-name` user:

Test with your own URL and API key (you will find the key in aws console apigateway -> apikeys): 
```
curl -H "x-api-key: rCeoPOSTEpHrogROKEvaL" https://kl4q7u9lg3.execute-api.eu-west-1.amazonaws.com/dev/hellojs/
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
- [ ] Cloudformation init
- [ ] Ci create + delete stack
- [ ] Add route53 domain + Cert
- [ ] Parameters SSM [here](https://www.youtube.com/watch?v=mDzjTe9WMnY&list=PLGyRwGktEFqe3-M1EfbpRX_syICmytNWx&index=8)