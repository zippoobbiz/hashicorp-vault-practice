# base image
FROM vault

ENV VAULT_ADDR="http://vault:8200"

# add the config, credential and template files
COPY ./config/vault-config.hcl /vault/config/vault-config.hcl
COPY ./template/companyinfo.kv.ctmpl /etc/vault/companyinfo.kv.ctmpl
COPY ./template/dbcredential.kv.ctmpl /etc/vault/dbcredential.kv.ctmpl
COPY ./credential/role-id /tmp/role-id
COPY ./credential/secret-id /tmp/secret-id

# run vault
ENTRYPOINT ["vault", "agent", "-config=/vault/config/vault-config.hcl"]