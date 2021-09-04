variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "cluster_name" {
  default = "eks-v01"
}

variable "container_security_api"{
    description = "Insertar aqui la API Key de Container Security"
}

variable "smartcheck_api"{
    description = "Insertar aqui la API Key de Smartcheck"
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "366666666666"    
  ]
}
