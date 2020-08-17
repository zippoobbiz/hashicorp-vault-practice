# LDAP secret engine

This secret engine allows Vault to keep your LDAP credentials and rotate it based on the TTL defined. Users with the proper policy can read the credentials from Vault.


## Start the openldap server in docker container

docker run \
  --name openldap \
  --env LDAP_ORGANISATION="learn" \
  --env LDAP_DOMAIN="learn.example" \
  --env LDAP_ADMIN_PASSWORD="2LearnVault" \
  -p 389:389 \
  -p 636:636 \
  --detach \
  --rm \
  --network=docker-compose_default \
  osixia/openldap:latest

## Check if the docker container is running

docker ps -f name=vault-openldap --format "table {{.Names}}\t{{.Status}}"

## Enable openldap in Vault

vault secrets enable openldap

## Write exmaple emtries to ldap

ldapadd -cxWD "cn=admin,dc=learn,dc=example" -f learn-vault-example.ldif

ldapsearch -x  -b "dc=learn,dc=example" -H ldap://127.0.0.1

## Config

vault write openldap/config \
    binddn=cn=admin,dc=learn,dc=example \
    bindpass=2LearnVault \
    url=ldap://openldap

## Rotate root credentials

vault write -f openldap/rotate-root

## Create a role

vault write openldap/static-role/learn \
    dn='cn=alice,ou=users,dc=learn,dc=example' \
    username='alice' \
    rotation_period="24h"

## Read the password

vault read openldap/static-cred/learn

# LDAP Auth method

Once configured, vault can validate the identity of a user against LDAP server, and map the user's LDAP dn to an identity in Vault with the policy attached. Then users who used LDAP to authenticate can start to use Vault resources.

## Enable auth method

vault auth enable ldap

## Config

vault write auth/ldap/config \
  url="ldap://openldap" \
  binddn="cn=admin,dc=learn,dc=example" \
  bindpass="2LearnVault" \
  insecure_tls=true \
  starttls=false

  vault write auth/ldap/groups/kv-reader policies=kv-reader

  vault write auth/ldap/users/alice policies=kv-admin
  vault write auth/ldap/users/phil policies=kv-admin

  vault write auth/ldap/config \
    url="ldap://openldap" \
    userdn="cn=alice,ou=users,dc=learn,dc=example" \
    groupdn="cn=dev,ou=groups,dc=learn,dc=example" \
    upndomain="example.com" \
    certificate=@ldap_ca_cert.pem \
    insecure_tls=false \
    starttls=true

vault login -method=ldap username=alice


ldapsearch -x -b "dc=learn,dc=example" -D "cn=admin,dc=learn,dc=example" -W 

2LearnVault