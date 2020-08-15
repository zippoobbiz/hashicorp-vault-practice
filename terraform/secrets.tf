resource "vault_mount" "kv2-secret-engine" {
  path        = "kv"
  type        = "kv-v2"
  description = "kv2 engine created by terraform"
}

resource "vault_generic_secret" "company-info" {
  path = "${vault_mount.kv2-secret-engine.path}/company-info"

  data_json = <<EOT
        {
        "company": "servian",
        "contact": "phil.xu"
        }
    EOT
}

resource "vault_generic_secret" "database-connect-string" {
  path = "${vault_mount.kv2-secret-engine.path}/database-connect-string"

  data_json = <<EOT
        {
        "username": "myusername",
        "password": "mypassword",
        "serverAddress": "http://xxx.xxx.xx.xx",
        "database": "mydatabase"

        }
    EOT
}