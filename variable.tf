variable "instance_iam_role_name" {
  type = string
  description = "list of managed and custom policies to be attached"
}

variable "instance_profile_policies_attachment" {
  type = list(string)
  description = "list of managed and custom policies to be attached"
  default = []
}

variable "global_tags" {
  type = object({
    Name = string
    Author      = string
    Environment = string
    Provisioner = string
    Region      = string
  })
  description = "base tags required in every resource"
}