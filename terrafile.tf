module "servers" {
    source = "./servers"
    instance_num = 3
}

output "instances_ips" {
  description = "Public IP of instances"
  value       = module.servers.instances_ips
}