variable "secret_name" {
  type    = string
  default = ""
}

variable "secret_plaintext_value" {
  type      = string
  sensitive = true
  default   = ""
}
