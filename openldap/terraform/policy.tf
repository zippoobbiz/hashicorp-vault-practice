# Admin
resource "vault_policy" "ldap-admin" {
  name = "ldap-admin"

  policy = <<EOT
                # Mount secrets engines
                path "sys/mounts/*" {
                  capabilities = [ "create", "read", "update", "delete", "list" ]
                }

                # Configure the openldap secrets engine and create roles
                path "openldap/*" {
                  capabilities = [ "create", "read", "update", "delete", "list" ]
                }

                # Write ACL policies
                path "sys/policies/acl/*" {
                  capabilities = [ "create", "read", "update", "delete", "list" ]
                }

                # Manage tokens for verification
                path "auth/token/create" {
                  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
                }
        EOT
}

# Users
resource "vault_policy" "openldap-reader" {
  name = "openldap-reader"

  policy = <<EOT
                path "openldap/*" {
                  capabilities = [ "read" ]
                }
        EOT
}

resource "vault_policy" "kv-reader" {
  name = "kv-reader"

  policy = <<EOT
                path "kv/*" {
                  capabilities = ["read", "list"]
                }
        EOT
}


