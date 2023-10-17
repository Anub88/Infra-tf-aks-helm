## App Registrations and Service Principals

The table below lists all existing app registrations in use to ensure it is clear whether they are automated or have to be created manually and to quickly reference them while developing and for security purposes.


|ID | Automated | App-reg. / Service Principal | Role Assignment | Affected Resources                                                                                                                                                     | Stored  | Notes                                                                                               |
|-|------------|------------------------------|------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---|-----------------------------------------------------------------------------------------------------|
|1| False      | app-aixs-shared-weus2       | Contributor      | [Defender Sub-Assesments API](https://learn.microsoft.com/en-us/rest/api/defenderforcloud/sub-assessments/get?tabs=HTTP) access for Vulnerability Notification LogicApp | Keyvault `kv-cicd-weus-buildagent` in secrets `vuln-log-not-clientId` `vuln-log-not-clientSecret`  | az ad sp create-for-rbac --role Contributor -n "app-aixs-shared-weus2" --scopes user_impersonation |
||            |                              |                  |                                                                                                                                                                         |   |                                                                                                     |
||            |                              |                  |                                                                                                                                                                         |   |                                                                                                     |
||            |                              |                  |                                                                                                                                                                         |   |                                                                                                     |
||            |                              |                  |                                                                                                                                                                         |   |                                                                                                     |
||            |                              |                  |                                                                                                                                                                         |   |                                                                                                     |
||            |                              |                  |                                                                                                                                                                         |   |                                                                                                     |


