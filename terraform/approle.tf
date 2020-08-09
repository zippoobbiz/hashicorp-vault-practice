resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_approle_auth_backend_role" "vault-agent" {
  backend        = vault_auth_backend.approle.path
  role_name      = "vault-agent"
  token_policies = ["default", vault_policy.kv-admin.name]
}

resource "vault_approle_auth_backend_role_secret_id" "vault-agent" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.vault-agent.role_name
}

resource "vault_approle_auth_backend_login" "vault-agent-login" {
  backend   = "${vault_auth_backend.approle.path}"
  role_id   = "${vault_approle_auth_backend_role.vault-agent.role_id}"
  secret_id = "${vault_approle_auth_backend_role_secret_id.vault-agent.secret_id}"
}

output "vault_agent_role_id" {
  value = vault_approle_auth_backend_role.vault-agent.role_id
}

output "vault_agent_secret_id" {
  value = vault_approle_auth_backend_role_secret_id.vault-agent.secret_id
}

output "vault_agent_approle_token" {
  value = vault_approle_auth_backend_login.vault-agent-login.client_token
}