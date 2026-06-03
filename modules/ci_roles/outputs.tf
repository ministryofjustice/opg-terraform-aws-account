output "aws_iam_role" {
  description = "CI role"
  value       = module.ci.aws_iam_role
}
