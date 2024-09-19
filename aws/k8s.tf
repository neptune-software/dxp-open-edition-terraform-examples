resource "kubectl_manifest" "namespace" {
  for_each = { for k, v in local.kubectl_manifests: k => v if strcontains(k, "namespace") }

  yaml_body = each.value.yaml_body
}

resource "kubectl_manifest" "manifest" {
  for_each = { for k, v in local.kubectl_manifests: k => v if !strcontains(k, "namespace") }

  yaml_body = each.value.yaml_body

  depends_on = [kubectl_manifest.namespace]
}
