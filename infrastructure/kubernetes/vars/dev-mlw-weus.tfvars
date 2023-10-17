app_env         = "dev"
subscription_id = "1fb500bc-6cb9-4087-97f0-8cc28b82ae40"

hdp_base_domain = "hdpcore-stage.zeiss.com"
hdp_auth_domain = "id-ip-stage.zeiss.com"
zeissid_api_domain = "zeissidapimanagementstage.azure-api.net"


kubernetes_services = {
  core_hdp_observer = {
    tag = "556424_whitelist_maringa_tenant_20230509085948_9c5b675"
    replica_count = 1
    name = ""
  }
  core_planner = {
    tag = "556424_whitelist_maringa_tenant_20230523133339_75934dd" 
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
    tag = "556424_whitelist_maringa_tenant_20230517145654_708b153"
    replica_count = 1
    name = ""
  }
  usecase_supervisor = {
    tag = "supervisor_gunicorn_debug_20230414121536_0e2f84a"
    replica_count = 1
    name = ""
  }
  usecase_maringa_model = {
    tag = "dev2--0.0.1--20230614143936--581981df314d17d5ffe4b33fb79663482bd779c0"
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
