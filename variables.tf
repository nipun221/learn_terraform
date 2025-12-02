# Define the AMI OS variable
variable "ami_os" {
    description = "The AMI OS type"
    type        = string
    default     = "ami-02b8269d5e85954ef" # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
}

# Define the instance type size variable
variable "instance_type_size" {
    description = "Size of the instance"
    type        = string
    default     = "t3.micro"
}

# Define the storage volume size variable
variable "storage_volume_size" {
    description = "Size of the storage volume in GB"
    type        = number
    default     = 8
}

# Define the delete on termination choice variable
variable "delete_on_termination_choice" {
    description = "Whether to delete the volume on instance termination"
    type        = bool
    default     = true
}

variable "storage_volume_type" {
    description = "Type of the storage volume"
    type        = string
    default     = "gp2"
}

# Define the S3 bucket name variable in run-time
variable "bucket_name" {
    description = "Name of the S3 bucket"
    type    = string
}