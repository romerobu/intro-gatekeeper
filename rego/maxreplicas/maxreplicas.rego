package maxreplicas

violation[{"msg": msg}] {
  replicas := input.review.object.spec.replicas
  max_replicas := input.parameters.replicas
  to_number(replicas) > to_number(max_replicas)
  msg := sprintf("Deployment %v pods is higher than the maximum allowed of %v", [replicas, max_replicas])
}

