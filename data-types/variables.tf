variable "elb_name" {
  type = string
  description = "ELB Name"
}

variable "azs" {
  type=list(string)
  description="List of AZ's for the ELB"
}

variable "idle_timeout"{
    type=number
    description="Idle Timeout of the ELB"
    default=400
}