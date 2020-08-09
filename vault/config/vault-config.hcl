storage "file" {
  path = "vault/data"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}

telemetry {
  statsd_address = "statsd:8125"
  disable_hostname = true
}

ui = true
api_addr = "https://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"
disable_performance_standby = true