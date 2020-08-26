pid_file = "./pidfile"

vault {
        address = "http://vault:8200"
}

auto_auth {
        method "approle" {
            mount_path = "auth/approle"
            config = {
                role_id_file_path = "/tmp/role-id"
                secret_id_file_path = "/tmp/secret-id"
                remove_secret_id_file_after_reading = false
            }
        }

        sink "file" {
                config = {
                        path = "/tmp/.vault-token"
                }
        }
}

cache {
        use_auto_auth_token = true
}


listener "tcp" {
         address = "127.0.0.1:8100"
         tls_disable = true
}

template {
  source      = "/etc/vault/companyinfo.kv.ctmpl"
  destination = "/etc/vault/company.info"
}

template {
  source      = "/etc/vault/dbcredential.kv.ctmpl"
  destination = "/etc/vault/db.credential"
}