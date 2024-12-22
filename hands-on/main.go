package main

import (
	"context"
	"errors"

	"github.com/aws/aws-lambda-go/lambda"
)

type MyEvent struct {
	Name string `json:"name"`
}

func HandleRequest(ctx context.Context, event *MyEvent) (*string, error) {
	if event == nil {
		return nil, errors.New("received nil event")
	}

	message := event.Name

	return &message, nil
}

func main() {
	lambda.Start(HandleRequest)
}
