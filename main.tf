
locals {
	policies = concat(var.policy_documents, [var.policy_document])
	json_policies = [for v in local.policies: jsondecode(v)]
	#json_policies = [for v in concat(var.policy_documents, [var.policy_document]): jsondecode(v)]
	version = "${ local.json_policies[0].Version }"
	statements = flatten([for policy in local.json_policies: policy.Statement])
	no_sid = [for policy in local.statements: policy if lookup(policy, "Sid", null) == null || lookup(policy, "Sid", "") == ""]
	sid = {for policy in local.statements: policy.Sid => policy... if lookup(policy, "Sid", null) != null && lookup(policy, "Sid", "") != ""}
	merged_sid = [for k,v in local.sid: local.sid[k][length(local.sid[k]) - 1]]
	merged_policy = { Version = local.version
	                  Statement = concat(local.no_sid, local.merged_sid) }
}

module "label" {
  source     = "../../cloudposse/terraform-null-label"
	#source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.1.3"
  attributes = var.attributes
  delimiter  = var.delimiter
  name       = var.name
  namespace  = var.namespace
  stage      = var.stage
  tags       = var.tags
  enabled    = var.enabled
	context    = var.context
}

resource "aws_iam_policy" "default" {
  count       = var.enabled == true ? 1 : 0
  name        = module.label.id
  description = var.policy_description
	policy      = jsonencode(local.merged_policy)
}
