variable "vpc_id" {
  type        = string
  description = "Target VPC ID"
}

variable "subnet_id" {
  type        = string
  description = "Target Subnet ID"
}

variable "vpc_id" {
  type        = string
  description = "Target VPC ID"
  default     = "vpc-052ff222828ac619f"
}

variable "subnet_id" {
  type        = string
  description = "Target Subnet ID"
  default     = "subnet-06657bf4922e3cc31"
}