package maxreplicas

test_replicas_no_violation {
  violation with input as {"review" : {"object" : {"spec": {"replicas": "1"}}}, "parameters": {"replicas": "2"}}
}

test_replicas_violation {
  violation[{"msg":"Deployment 5 pods is higher than the maximum allowed of 2"}] with input as {"review" : {"object" : {"spec": {"replicas": "5"}}}, "parameters": {"replicas": "2"}}
}


