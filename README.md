# cloud-appliance-management

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| openstack | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_inbound\_security\_group\_count | The number of entries in var.allowed\_inbound\_security\_group\_ids. Ideally, this value could be computed dynamically, but we pass this variable to a Terraform resource's 'count' property and Terraform requires that 'count' be computed with literals or data sources only. | `number` | `0` | no |
| allowed\_inbound\_security\_group\_ids | A list of security group IDs that will be allowed to connect to Consul | `list(string)` | `[]` | no |
| back\_net\_id | Backoffice network ID to use for the appliance | `string` | n/a | yes |
| cli\_rpc\_port | The port used by all agents to handle RPC from the CLI. | `number` | `8400` | no |
| consul\_datacenter | Datacenter name used by Consul agent | `string` | n/a | yes |
| consul\_dns\_domain | DNS domain used by Consul agent | `string` | n/a | yes |
| consul\_dns\_server | IP address to use for non-consul-managed domains | `string` | n/a | yes |
| consul\_encrypt | Consul shared secret for cluster communication | `string` | n/a | yes |
| default\_secgroup\_id | Default security group to use | `string` | n/a | yes |
| dns\_port | The port used to resolve DNS queries. | `number` | `8600` | no |
| flavor\_name | Cloud flavor to use | `string` | n/a | yes |
| front\_net\_id | Network ID to use for the appliance | `string` | n/a | yes |
| git\_repo\_checkout | branch/tag/commit to use | `string` | `"master"` | no |
| git\_repo\_password | git password | `string` | `""` | no |
| git\_repo\_url | cloud-appliance-management repo | `string` | `"https://github.com/mgrzybek/cloud-appliance-management"` | no |
| git\_repo\_username | git username | `string` | `""` | no |
| http\_api\_port | The port used by clients to talk to the HTTP API | `number` | `8500` | no |
| image\_name | Operating system image to use | `string` | n/a | yes |
| internet\_http\_no\_proxy | Proxy skiplist | `string` | `""` | no |
| internet\_http\_proxy\_url | HTTP proxy | `string` | `""` | no |
| ntp\_server | Remote NTP to use for sync | `string` | `""` | no |
| os\_auth\_url | Cloud auth URL | `string` | n/a | yes |
| os\_password | Cloud password for some internal batches | `string` | n/a | yes |
| os\_region\_name | Cloud region name | `string` | n/a | yes |
| os\_username | Cloud username for some internal batches | `string` | n/a | yes |
| serf\_lan\_port | The port used to handle gossip in the LAN. Required by all agents. | `number` | `8301` | no |
| serf\_wan\_port | The port used by servers to gossip over the WAN to other servers. | `number` | `8302` | no |
| server\_rpc\_port | The port used by servers to handle incoming requests from other agents. | `number` | `8300` | no |
| static\_hosts | JSON array of host:ip tuples | `string` | `""` | no |
| traefik\_consul\_prefix | Prefix used in services metadata to manage traefik's attributes | `string` | `"admin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| appliance\_back\_ip | Back office IPv4 address |
| appliance\_back\_port | Back office port ID |
| appliance\_front\_ip | Front office IPv4 address |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

