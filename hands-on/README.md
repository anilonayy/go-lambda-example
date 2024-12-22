# Go Lambda Hands-On

# Build Stage

### Build Lambda Function
```bash
GOOS=linux GOARCH=amd64 go build -tags lambda.norpc -o bootstrap main.go
```

### Create zip file for Lambda Function
```bash
zip bootstrap.zip bootstrap
```

### Create Role for Lambda Function
```bash
aws iam create-role --role-name myFunctionExecRole --assume-role-policy-document file://trust-policy.json
```

### Attach Policy to Role
```bash
aws iam attach-role-policy --role-name myFunctionExecRole --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
```

### Create Lambda Function

```bash
aws lambda create-function --function-name myFunction \
--runtime provided.al2023 --handler bootstrap \
--architectures x86_64 \
--role arn:aws:iam::<<account-id>>:role/myFunctionExecRole \
--zip-file fileb://bootstrap.zip
```

# Tests Stage

### Test Lambda Function
```bash
aws lambda invoke --function-name myFunction \
--cli-binary-format raw-in-base64-out \
--payload '{"name": "John"}' output.txt
```
