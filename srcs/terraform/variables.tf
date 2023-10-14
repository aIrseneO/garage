variable "filename" {
  default = [
    "cat.txt",
    "dog.txt",
    "lion.txt"
  ]
  type        = set(string)
  description = "Name of the file"
}

variable "content" {
  default     = "Zlatan From variables.tf"
  type        = string
  description = "Content of the file"
}

variable "prefix" {
  default     = ["Mrs", "Mr", "Sir"]
  type        = list(any)
  description = "Here come the prefix"
}

variable "separator" {
  default     = "."
  type        = string
  description = "Separator"
}

variable "length" {
  default     = "2"
  type        = string
  description = "Length"

}
