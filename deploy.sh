./build.sh
aws ecs update-service --cluster cluster-imersao-aws-treino --service service-imersao-aws-treino  --force-new-deployment --profile imersaoawstreino