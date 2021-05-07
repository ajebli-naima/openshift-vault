path "database/creds/backend" {
    capabilities = ["read", "list"]
}
path "cubbyhole/backend" { 
    capabilities = ["read", "list"] 
}
path "cubbyhole/application" { 
    capabilities = ["read", "list"] 
}
path "sys/leases/renew" {
    capabilities = ["update"] 
}

path "sys/renew/*" {
    policy = "write"
}