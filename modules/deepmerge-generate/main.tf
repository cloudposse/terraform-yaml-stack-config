resource "local_file" "depth" {
  content  = templatefile("${path.module}/../deepmerge/depth.tmpl", { max_depth = 20 })
  filename = "${path.module}/../deepmerge/depth.tf"
}
