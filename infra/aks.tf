
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "w255-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "w255"

  kubernetes_version = "1.21.7"

  default_node_pool {
    name                = "default"
    min_count           = 3
    max_count           = 20
    vm_size             = "Standard_D2_v3"
    enable_auto_scaling = true
    # os_disk_type        = "Ephemeral"
  }

  auto_scaler_profile {

  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed            = true
      azure_rbac_enabled = true
    }
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
  }

  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_role_assignment" "acr_access" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}