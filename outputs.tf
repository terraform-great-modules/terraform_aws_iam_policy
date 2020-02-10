
output "arn" {
	value = aws_iam_policy.default[0].arn
	description = "The arn of the policy object"
}
output "json_document" {
	value = jsonencode(local.merged_policy)
}
