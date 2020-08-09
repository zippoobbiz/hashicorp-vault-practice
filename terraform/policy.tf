resource "vault_policy" "kv-admin" {
  name = "kv-admin"

  policy = <<EOT
                path "kv/*"
                {
                    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
                }
        EOT
}