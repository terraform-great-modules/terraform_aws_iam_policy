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
variable "policy_version" {
  type        = string
  default     = "2012-10-17"
  description = "Policy version, eigther 2012-10-17 or 2008-10-17"
}

# Status
#
variable "debug" {
  type        = bool
  description = "enable for local debug"
  default     = true
}

# Label definition
#
variable "name" {
  type        = string
  default     = ""
  description = "Policy name"
}

variable "description" {
  type        = string
  default     = null
  description = "Policy description"
}

variable "path" {
  type        = string
  default     = null
  description = "Policy path definition (optional)"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Tags for policy"
}
