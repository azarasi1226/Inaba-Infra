locals {
    resource_prefix = "momiji-dev"
}

# ネットワーク
module "network" {
  source = "../../modules/network"

    resource_prefix = local.resource_prefix
}

# コンテナ基盤
module "container_base" {
    source = "../../modules/container_base"

    resource_prefix = local.resource_prefix
}

# フロントエンド
module "frontend" {
    source = "../../services/frontend"

    resource_prefix = local.resource_prefix
    vpc_id = module.network.vpc_id
    cluster_arn = module.container_base.ecs_cluster_arn
    container_private_subnet_ids = module.network.container_private_subnet_ids
    alb_public_subnet_ids = module.network.ingress_public_subnet_ids
}

# バックエンド　
module "backend" {
    source = "../../services/backend"
}