
output "arn" {
  value       = try(aws_iam_policy.default[0].arn, null)
  description = "The arn of the policy object"
}
output "json_document" {
  value = jsonencode(local.merged_policy)
}
