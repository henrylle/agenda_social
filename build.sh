docker build -t imersao-aws .
aws ecr get-login-password --region us-east-1  --profile imersaoawstreino | docker login --username AWS --password-stdin 053481394261.dkr.ecr.us-east-1.amazonaws.com
docker tag imersao-aws:latest 053481394261.dkr.ecr.us-east-1.amazonaws.com/imersaoawstreino:latest
docker push 053481394261.dkr.ecr.us-east-1.amazonaws.com/imersaoawstreino:latest