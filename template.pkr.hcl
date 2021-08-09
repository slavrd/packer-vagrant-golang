
variable "base_box" {
  type    = string
  default = "ubuntu/focal64"
}

variable "golang_file" {
  type    = string
  default = "go1.16.6.linux-amd64.tar.gz"
}

variable "skip_add" {
  type    = bool
  default = true
}

source "vagrant" "ubuntu-golang" {
  add_force    = true
  communicator = "ssh"
  provider     = "virtualbox"
  skip_add     = var.skip_add
  source_path  = var.base_box
}

build {
  sources = ["source.vagrant.ubuntu-golang"]

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive", "GOLANG_FILE=${var.golang_file}"]
    execute_command  = "echo 'vagrant' | {{ .Vars }} sudo -E -S bash {{ .Path }}"
    scripts          = ["scripts/provision.sh", "scripts/cleanup_final.sh"]
  }

}
