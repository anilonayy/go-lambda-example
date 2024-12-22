# Golang Lambda Example

This is a simple example of how to create a scheduled lambda function using different methods.

After the lambda function is created, the triggering history of the lambda can be examined from the Log Group that matches the function name via CloudWatch.

## Methods

- [Hands-On (AWS CLI)](./hands-on)
- [AWS SAM](./sam)
- [Terraform](./terraform)

```tree
├── .gitignore
├── README.md
├── events
│   └── event.json
├── hands-on
│   ├── README.md
│   ├── go.mod
│   ├── go.sum
│   ├── main.go
│   ├── presentation
│   │   └── test.png
│   └── trust-policy.json
├── sam
│   ├── Makefile
│   ├── README.md
│   ├── hello-world
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── main.go
│   │   └── main_test.go
│   ├── samconfig.toml
│   └── template.yaml
└── terraform
    ├── README.md
    ├── go.mod
    ├── go.sum
    ├── lambda.zip
    ├── main.go
    └── main.tf
```
