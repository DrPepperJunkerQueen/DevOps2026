variable "prefix" {
  description = "Prefiks dla nazw zasobow — uzyj swojego numeru indeksu (tylko litery i cyfry, max 12 znakow, np. devops123456)"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,12}$", var.prefix))
    error_message = "Prefix moze zawierac tylko male litery i cyfry, dlugosc 3-12 znakow."
  }
}

variable "location" {
  description = "Region Azure"
  type        = string
  default     = "swedencentral"
}

variable "admin_username" {
  description = "Nazwa uzytkownika SSH dla VM"
  type        = string
  default     = "DrPepperJunkerQueen"
}

variable "ssh_public_key" {
  description = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDc1gQ5M+vbeTbJ9bS+OiX2ccO5rbfxQzGRKCKPR17NkV6DfcdpgVRg4cLVnJ2208JItOb78kOPGzj7qVx/st+CjNq6DGn1cO8+ZLxy0bcIYZPI0xJ0gd2qxA0XQbf6C5QGm7o3mBDGDo1Kduytd/ny1Z8d3XopxjI8PkMmc4se44AY+dflMnOS5OzhhrvqlLfWuwKYuxEa7H0SG8T99CjO1W5Z4YkWw84l+/LkbQwrN5ZozNqTOOW3fhX7fCXYt/bpl6YTMoQysktU2r/Yze3fHCIeKDf7MhpfE+CMvqmun8MyiVUh0eIVZYhMjmATszs1MzdbCb15Azwbp5HLozbBD9d+Jrr9QdKi5UXaZ/n5fD4i+e+djzYuNgIXuDYEvoM2gLak4Y6T5WTvuAWx1kqqge13vG5m4V9SUIBm6FdZlRjqj0td5R3qoKUY9DZglcJUPQ8Sw523CLFH3gwWzieKspO2I5b2zA0maNUUAZceHJbK4Hprzhtmg/7Lf2StrHAU13TLxgjo9t+Bi2Wd13XK2/huqmZm0/No2ld7HeHvm+4uTtZTq7Gl9dN3hSnbGmOXUqd6wDm17o8dGZ/NGVxwCl5An3/gQd+BGVJZsakclhnU4GfxyjqI9AsFIyyvjWnKSd20B5Fnwp2cWhJOrxUEHyJLjP6nAwv3IF8kI3qtQw== devops-lab10"
  type        = string
  sensitive   = true
}
