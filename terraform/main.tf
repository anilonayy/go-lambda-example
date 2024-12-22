locals {
  project = "scheduled-lambda"
  environment = "dev"

  common_tags = {
    Project = local.project
    Environment = local.environment
    Terraform = "true"
  }

  lambda_name = "${local.project}-${local.environment}-scheduled-task"
  lambda_timeout = 300
  lambda_memory  = 128
}

# Defines IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "${local.lambda_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the BasicExecutionRole to the Lambda's Role
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

# Defines the Lambda Function
resource "aws_lambda_function" "scheduled_lambda" {
  filename         = "lambda.zip" # Go binary's zip file
  function_name    = local.lambda_name
  role            = aws_iam_role.lambda_role.arn
  handler         = "bootstrap" # Go handler name is usually bootstrap
  runtime         = "provided.al2"

  environment {
    variables = {
      # Required environment variables
    }
  }
}

# EventBridge Rule
resource "aws_cloudwatch_event_rule" "schedule" {
  name                = "${local.lambda_name}-rule"
  description         = "Triggers Lambda at regular intervals"
  schedule_expression = "rate(10 minutes)" # You can set the interval you want

  tags = local.common_tags
}

# EventBridge Target
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.schedule.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.scheduled_lambda.arn
}

# Lambda's EventBridge trigger permission
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.scheduled_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule.arn
}