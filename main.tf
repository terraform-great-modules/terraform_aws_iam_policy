
locals {
  create_policy = try(length(var.name), 0) == 0 ? 0 : 1
  policies      = concat(var.policy_documents, [var.policy_document])
  json_policies = [
    for v in local.policies : jsondecode(v)
    if v != null && v != "" && can(jsondecode(v))
  ]
  json_policies_error = [
    for v in local.policies : jsondecode(v)
    if v != null && v != "" && can(jsondecode(v)) == false
  ]
  version    = var.policy_version
  statements = flatten([for policy in local.json_policies : policy.Statement])

  no_sid = [
    for policy in local.statements : policy
    if lookup(policy, "Sid", null) == null || lookup(policy, "Sid", "") == ""
  ]
  sid = {
    for policy in local.statements : policy.Sid => policy...
    if lookup(policy, "Sid", null) != null && lookup(policy, "Sid", "") != ""
  }
  merged_sid = [
    for k, v in local.sid : local.sid[k][length(local.sid[k]) - 1]
  ]
  merged_policy = {
    Version   = local.version
    Statement = concat(local.no_sid, local.merged_sid)
  }
}

resource "null_resource" "assert_something" {
  count = length(local.json_policies_error)

  provisioner "local-exec" {
    command     = local.json_policies_error
    interpreter = ["bash", "-c", "echo"]
  }
  provisioner "local-exec" {
    command     = "false"
    interpreter = ["bash", "-c"]
  }
}

resource "aws_iam_policy" "default" {
  count = local.create_policy
  name  = var.name
  # name_prefix
  description = var.description
  policy      = jsonencode(local.merged_policy)
  path        = var.path
  tags        = var.tags
}
