variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "aws_spinnaker_amis" {
  "default" = {
    "ap-northeast-1-hvm" = "ami-b2ad57d3"
    "ap-southeast-1-hvm" = "ami-69d30c0a"
    "ap-southeast-2-hvm" = "ami-7a516419"
    "eu-central-1-hvm" = "ami-b12edade"
    "eu-west-1-hvm" = "ami-546f0227"
    "sa-east-1-hvm" = "ami-f3e1769f"
    "us-east-1-hvm" = "ami-4153d956"
    "us-west-1-hvm" = "ami-87dc9de7"
    "us-west-2-hvm" = "ami-21a26d41"
  }
}

variable "instance_type" {
	description = "The type of jenkins instance to start"
	type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "subnet_ids" {
  description = "List of Subnet Ids"
  type        = "list"
  default     = []
}

variable "associate_public_ip_address" {
	description = "If true, the EC2 instance will have associated public IP address"
	type        = bool
	default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(map(string))
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}
