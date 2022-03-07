resource "local_file" "foo" {
  for_each = toset(local.students)
  content  = <<-EOT
    apiVersion: v1
    kind: Namespace
    metadata:
      name: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}
      labels:
        istio-injection: enabled
    ---
    kind: Role
    apiVersion: rbac.authorization.k8s.io/v1
    metadata:
      name: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}-full-access
      namespace: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}
    rules:
    - apiGroups: ["", "extensions", "apps", "networking.istio.io"]
      resources: ["*"]
      verbs: ["*"]
    - apiGroups: ["batch"]
      resources:
      - jobs
      - cronjobs
      verbs: ["*"]
    ---
    kind: RoleBinding
    apiVersion: rbac.authorization.k8s.io/v1
    metadata:
      name: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}-user-access
      namespace: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: Role
      name: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}-full-access
    subjects:
    - kind: User
      namespace: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}
      name: ${lookup(local.email_to_id, each.key)}
    # ---
    # apiVersion: v1
    # kind: ResourceQuota
    # metadata:
    #   name: resource-quota-${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}
    #   namespace: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}
    # spec:
    #   hard:
    #     requests.cpu: "4"
    #     requests.memory: 8Gi
    #     limits.cpu: "8"
    #     limits.memory: 16Gi
    ---
    kind: Role
    apiVersion: rbac.authorization.k8s.io/v1
    metadata:
      name: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}-istio-access
      namespace: istio-system
    rules:
    - apiGroups: [""]
      resources: ["pods/portforward"]
      verbs: ["*"]
    ---
    kind: RoleBinding
    apiVersion: rbac.authorization.k8s.io/v1
    metadata:
      name: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}-istio-access
      namespace: istio-system
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: Role
      name: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}-istio-access
    subjects:
    - kind: User
      namespace: ${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}-istio-access
      name: ${lookup(local.email_to_id, each.key)}
    ---
    EOT
  filename = "yamls/${lower(replace(replace(split("@", each.key)[0], ".", ""), "_", "-"))}.yaml"
}

