resource "local_file" "pet" {
  filename = "${path.root}/${each.value}"
  for_each = var.filename
  content  = "${var.content} - Mypet: ${random_pet.my_pet.id}"

  depends_on = [
    random_pet.my_pet
  ]

  lifecycle {
    create_before_destroy = true
    # prevent_destroy = true
  }

  
}

resource "random_pet" "my_pet" {
  prefix    = var.prefix[2]
  separator = var.separator
  length    = var.length
}

data "local_file" "os_release" {
  filename = "/etc/os-release"
}

# variable "content" {}