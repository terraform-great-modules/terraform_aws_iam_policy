#
# Policy document(s) definition
#
variable "policy_documents" {
  type        = list(string)
  description = "List of JSON IAM policy documents to merge together"
  default     = []
}
variable "policy_document" {
  type        = string
  description = "Single json dump of policy statements"
  default     = ""
}
variable "policy_description" {
  type        = string
  description = "Description of policy content"
  default     = "Managed by Terraform"
}

#
# Status
#
variable "enabled" {
  type        = bool
  description = "false to do not generate the policy"
  default     = true
}

variable "debug" {
	type        = bool
	description = "enable for local debug"
	default     = true 
}
#
# Label definition
#
variable "context" {
  type = object({
    namespace           = string
    environment         = string
    stage               = string
    name                = string
    enabled             = bool
    delimiter           = string
    attributes          = list(string)
    label_order         = list(string)
    tags                = map(string)
    additional_tag_map  = map(string)
    regex_replace_chars = string
  })
  default = {
    namespace           = ""
    environment         = ""
    stage               = ""
    name                = ""
    enabled             = true
    delimiter           = ""
    attributes          = []
    label_order         = []
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = ""
  }
  description = "Default context to use for passing state between label invocations"
}
variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace (e.g. `cp` or `cloudposse`)"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
}

variable "name" {
  type        = string
  default     = ""
  description = "Name (e.g. `app` or `chamber`)"
}

variable "use_fullname" {
  type        = string
  default     = "true"
  description = "Set 'true' to use `namespace-stage-name` for ecr repository name, else `name`"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}
