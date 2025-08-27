output "kube_config" {
  value = azurerm_kubernetes_cluster.cems_aks_cluster.kube_config_raw
  sensitive = true
}