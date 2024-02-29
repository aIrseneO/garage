# Garage

## Run aws cli using docker
```bash
docker pull amazon/aws-cli
docker run --rm -it amazon/aws-cli --version
docker run --rm -it amazon/aws-cli help
docker run --rm -ti -v ~/.aws:/root/.aws amazon/aws-cli s3 ls
docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli s3 cp s3://aws-cli-docker-demo/hello .

alias aws="docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli"
aws --version
```

## AWS config and credentials files
```config
# ~/.aws/config
[default]
region = ...
output = json

# ~/.aws/credentials
[default]
aws_access_key_id = ...
aws_secret_access_key = ...
```

## [ECR](https://docs.aws.amazon.com/ecr/index.html)
### ECR URL: `https://<aws_account_id>.dkr.ecr.<region>.awazonaws.com`
### Authorization TOKEN
```bash
aws ecr get-login-password --region <region> \
    | docker login --username AWS \
    --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
aws ecr get-login-password --regoin region | docker login -u AWS -p 

aws ecr list-images --repository-name <repository>
aws ecr get-login-password --region <region> | docker login -u AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/<repository>:tag
```