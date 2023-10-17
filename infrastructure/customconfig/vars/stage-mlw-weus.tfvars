app_env = "stage"

aks_node_pools = {
  "l1aixs" = {
    vm_size    = "Standard_D2s_v3"
    node_count = 1
    required   = true
    node_labels = { 
      "compute"="D2sv3_lin_01"
      "name"="l1aixs"
    }
    os_type    = "Linux"
  }
  "w1aixs" = {
    vm_size    = "Standard_D2s_v3"
    node_count = 1
    required   = true
    node_labels= { 
      "compute"="D2sv3_win_01"
      "name"="w1aixs"
    }
    os_type    = "Windows"
    orchestrator_version = 1.24
  }

  "l2aixs" = {
    vm_size    = "Standard_B4ms"
    node_count = 1
    required   = false
    node_labels= { 
      "compute"="B4ms_lin_01"
      "name"="l2aixs"
    }
    os_type    = "Linux"
  }
  "w2aixs" = {
    vm_size    = "Standard_B4ms"
    node_count = 1
    required   = false
    node_labels= { 
      "compute"="B4ms_win_01"
      "name"="w2aixs"
    }
    os_type    = "Windows"
  }

  "l3aixs" = {
    vm_size    = "Standard_D8s_v3"
    node_count = 1
    required   = false
    node_labels= { 
      "compute"="D8sv3_lin_01"
      "name"="l3aixs"
    }
    os_type    = "Linux"
  }
  "w3aixs" = {
    vm_size    = "Standard_D8s_v3"
    node_count = 1
    required   = false
     node_labels= { 
      "compute"="D8sv3_win_01"
      "name"="w3aixs"
    }
    os_type    = "Windows"
  }

  "l4aixs" = {
    vm_size    = "Standard_D16s_v3"
    node_count = 1
    required   = false
    node_labels= { 
      "compute"="D16sv3_lin_01"
      "name"="l4aixs"
    }
    os_type    = "Linux"
  }
  "w4aixs" = {
    vm_size    = "Standard_D16s_v3"
    node_count = 1
    required   = false
     node_labels= { 
      "compute"="D16sv3_win_01"
      "name"="w4aixs"
    }
    os_type    = "Windows"
  }

  "l5aixs" = {
    vm_size    = "Standard_NC4as_T4_v3"
    node_count = 1
    required   = false
    node_labels= { 
      "compute"="NC4asT4v3_lin_01"
      "name"="l5aixs"
    }
    os_type    = "Linux"
  }
  "w5aixs" = {
    vm_size    = "Standard_NC4as_T4_v3"
    node_count = 1
    required   = false
      node_labels= { 
      "compute"="NC4asT4v3_win_01"
      "name"="w5aixs"
    }
    os_type    = "Windows"
  }

  "l6aixs" = {
    vm_size    = "Standard_NC16as_T4_v3"
    node_count = 1
    required   = false
    node_labels= { 
      "compute"="NC16asT4v3_lin_01"
      "name"="l6aixs"
    }
    os_type    = "Linux"
  }
  "w6aixs" = {
    vm_size    = "Standard_NC16as_T4_v3"
    node_count = 1
    required   = false
    node_labels= { 
      "compute"="NC16asT4v3_win_01"
      "name"="w6aixs"
    }
    os_type    = "Windows"
  }

  "l7aixs" = {
    vm_size    = "Standard_NC6s_v3"
    node_count = 1
    required   = false
    node_labels= { 
      "compute"="NC6sv3_lin_01"
      "name"="l7aixs"
    }
    os_type    = "Linux"
  }
  "w7aixs" = {
    vm_size    = "Standard_NC6s_v3"
    node_count = 1
    required   = false
    node_labels= { 
      "compute"="NC6sv3_win_01"
      "name"="w7aixs"
    }
    os_type    = "Windows"
  }
}

usecase_id = ["123abc", "456asdf"]