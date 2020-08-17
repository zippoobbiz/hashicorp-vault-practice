resource "vault_generic_secret" "company-info" {
  path = "kv/company-info"

  data_json = <<EOT
        {
        "company": "servian",
        "contact": "phil.xu"
        }
    EOT
}

resource "vault_generic_secret" "database-connect-string" {
  path = "kv/database-connect-string"

  data_json = <<EOT
        {
        "username": "myusername",
        "password": "mypassword",
        "serverAddress": "http://xxx.xxx.xx.xx",
        "database": "mydatabase"

        }
    EOT
}