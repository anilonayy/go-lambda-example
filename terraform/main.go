package main

import (
	"context"
	"log"

	"github.com/aws/aws-lambda-go/lambda"
)

type Event struct {
	Name string `json:"name"`
}

func handler(ctx context.Context, event Event) error {
	log.Printf("Lambda Worked! Input:%s \n", event.Name)

	return nil
}

func main() {
	lambda.Start(handler)
}
