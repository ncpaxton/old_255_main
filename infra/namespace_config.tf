resource "local_file" "foo" {
  for_each = toset(local.students)
  content  = <<-EOT
    apiVersion: v1
    kind: Namespace
    metadata:
      name: ${lower(replace(split("@", each.key)[0], ".", ""))}
    ---
    kind: Role
    apiVersion: rbac.authorization.k8s.io/v1
    metadata:
      name: ${lower(replace(split("@", each.key)[0], ".", ""))}-full-access
      namespace: ${lower(replace(split("@", each.key)[0], ".", ""))}
    rules:
    - apiGroups: ["", "extensions", "apps"]
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
      name: ${lower(replace(split("@", each.key)[0], ".", ""))}-user-access
      namespace: ${lower(replace(split("@", each.key)[0], ".", ""))}
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: Role
      name: ${lower(replace(split("@", each.key)[0], ".", ""))}-full-access
    subjects:
    - kind: User
      namespace: ${lower(replace(split("@", each.key)[0], ".", ""))}
      name: ${lookup(local.email_to_id, each.key)}
    ---
    apiVersion: v1
    kind: ResourceQuota
    metadata:
      name: resource-quota-${lower(replace(split("@", each.key)[0], ".", ""))}
      namespace: ${lower(replace(split("@", each.key)[0], ".", ""))}
    spec:
      hard:
        requests.cpu: "4"
        requests.memory: 8Gi
        limits.cpu: "8"
        limits.memory: 16Gi
    EOT
  filename = "yamls/${lower(replace(split("@", each.key)[0], ".", ""))}.yaml"
}

