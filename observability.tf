
# --- CLOUDWATCH & ECR ---
resource "aws_cloudwatch_log_group" "LogsLogGroup" {
  name              = "/aws/ecs/containerinsights/my-app-dev-cluster/performance"
  retention_in_days = 1
}

resource "aws_ecr_repository" "ECRRepository" {
  name = "hello-eks"
}

resource "aws_ecr_repository" "ECRRepository2" {
  name = "my-app"
}