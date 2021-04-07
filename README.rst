
=================================
Terraform AWS Policy and document
=================================

This formula:

- merge the json documents and the document provided
- create a policy (if name is provided)

The merging is done by overriding by statement sid (if present).
