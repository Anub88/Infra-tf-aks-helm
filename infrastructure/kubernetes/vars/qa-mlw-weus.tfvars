app_env         = "qa"
subscription_id = "1fb500bc-6cb9-4087-97f0-8cc28b82ae40"

hdp_base_domain = "hdpcore-stage.zeiss.com"
hdp_auth_domain = "id-ip-stage.zeiss.com"
zeissid_api_domain = "zeissidapimanagementstage.azure-api.net"


kubernetes_services = {
  core_hdp_observer = {
    tag = "592829_hdp_observer_whitelist_tenant_20230721090225_c60630a"
    replica_count = 1
    name = ""
  }
  core_planner = {
    tag = "592829_planner_s2s_revert_20230721081940_eb67130"
    replica_count = 1
    name = ""
  }
  core_manager = {
    tag = "latest"
    replica_count = 1
    name = ""
  }
  usecase_configuration = {
    tag = "main_20230316060559_199784f"
    replica_count = 1
    name = ""
  }
  usecase_maringa_connector = {
    tag = "main_20230707072630_ca2708a"
    replica_count = 1
    name = ""
  }
  usecase_supervisor = {
    tag = "main_20230706095646_54af648"
    replica_count = 1
    name = ""
  }
  usecase_maringa_model = {
    tag = "dev2--0.0.1--20230525153119--653f47d9c21fd464bd707206ab894f79e4d0db7b"
    replica_count = 1
    name = "maringa"
  }
  usecase_odx_model = {
    tag = "1a9f044"
    replica_count = 1
    name = "odx"
  }
   ai_manager ={
    tag = "latest"
    replica_count = 1
    name = ""
  }
}