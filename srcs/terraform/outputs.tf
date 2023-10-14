output "name" {
  value = random_pet.my_pet.id
}

output "os_release" {
  value = data.local_file.os_release.content
}