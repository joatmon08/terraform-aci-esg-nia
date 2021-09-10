variable "prefix" {
  type = string
}

variable "url" {
  type = string
}

variable "username" {
  type    = string
  default = "admin"
}

variable "password" {
  type      = string
  sensitive = true
}