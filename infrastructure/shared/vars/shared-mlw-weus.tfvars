resource_group_name = "rg-mlws-shared-weus"
app_env             = "shared"

buildagent_resource_group = "rg-cicd-weus-buildagent"
buildagent_vnet_name      = "vnet-cicd-weus-buildagent"




lg_vuln_not_kv_api_name              = "vuln-notification-kv-apiconn"
lg_vuln_not_office_api_name          = "vuln-notification-office365-apiconn"
lg_vuln_not_kv_conn                  = "/subscriptions/1fb500bc-6cb9-4087-97f0-8cc28b82ae40/resourceGroups/rg-mlws-shared-weus/providers/Microsoft.Web/connections/vuln-notification-kv-apiconn"
lg_vuln_not_office_conn              = "/subscriptions/1fb500bc-6cb9-4087-97f0-8cc28b82ae40/resourceGroups/rg-mlws-shared-weus/providers/Microsoft.Web/connections/vuln-notification-office365-apiconn"
lg_vuln_not_kv_name                  = "kv-cicd-weus-blagt"
lg_vuln_not_kv_rg                    = "rg-cicd-weus-buildagent"
lg_vuln_not_name                     = "aixs-vulnnot-shared-weus"
lg_vuln_not_app_reg_name             = "appreg_vuln_notification_la"
lg_vuln_not_kv_deployment_name       = "logicapp-keyvault-connection-deployment"
lg_vuln_not_office_deployment_name   = "logicapp-office-connection-deployment"
lg_vuln_not_logicapp_deployment_name = "vuln-not-logicapp-deployment"


lg_cld_alert_name                     = "la-aixs-sec-weus"
lg_cld_alert_msteams_conn             = "/subscriptions/1fb500bc-6cb9-4087-97f0-8cc28b82ae40/resourceGroups/rg-mlws-shared-weus/providers/Microsoft.Web/connections/teams"
lg_cld_alert_asc_conn                 = "/subscriptions/1fb500bc-6cb9-4087-97f0-8cc28b82ae40/resourceGroups/rg-mlws-shared-weus/providers/Microsoft.Web/connections/ascalert"
lg_cld_alert_teams_api_name           = "teams"
lg_cld_alert_asc_api_name             = "ascalert"
lg_cld_alert_logicapp_deployment_name = "la-cloud-defender-wf-deployment"
lg_cld_alert_msteams_deployment_name  = "la-teams-conn-deployment"
lg_cld_alert_asc_deployment_name      = "la-ascalert-conn-deployment"