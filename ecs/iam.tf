#################################################################################################
# This file describes the IAM resources: ECS task role, ECS execution role
#################################################################################################

resource "aws_iam_role" "ecsTaskExecutionRole" {
    name                  = "${random_string.string.id}-app-ecsTaskExecutionRole"
    assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions               = ["sts:AssumeRole"]

    principals {
      type                = "Service"
      identifiers         = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
    role                  = aws_iam_role.ecsTaskExecutionRole.name
    policy_arn            = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecsTaskRole" {
    name                  = "${random_string.string.id}-ecsTaskRole"
    assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json   
}

resource "aws_iam_role_policy_attachment" "ecsTaskRole_policy" {
    role                  = aws_iam_role.ecsTaskRole.name
    policy_arn            = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}