app_env         = "stage"
subscription_id = "289e8341-6147-4fb6-897f-fa66a4919e8a"

hdp_base_domain = "hdpcore-stage.zeiss.com"
hdp_auth_domain = "id-ip-stage.zeiss.com"
zeissid_api_domain = "zeissidapimanagementstage.azure-api.net"


kubernetes_services = {
  core_hdp_observer = {
    tag = "main_20230330070529_8bffa5f"
    replica_count = 1
    name = ""
  }
  core_planner = {
    tag = "maringa_configuration_update_20230414135538_39576e0"
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
    tag = "connector_gunicorn_debug_20230414060537_72fa6a5"
    replica_count = 1
    name = ""
  }
  usecase_supervisor = {
    tag = "supervisor_gunicorn_debug_20230414121536_0e2f84a"
    replica_count = 1
    name = ""
  }
  usecase_maringa_model = {
    tag = "Demo-Maringa--0.0.1--20230414121008--4efbbca98db6b622ea47b6ae77cc269f72e03216"
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