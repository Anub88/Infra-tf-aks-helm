
# Azure Defender
Defender should be enabled for all production resources in use.

# Azure Sentinel
Microsoft Sentinel analyzes, interacts and derives insights from large volumes of data stored in an Azure Monitor Log Analytics workspaces.

```
// Note: These where examples the security team found useful, they are not used yet as we have no real data to test against.
// 
// Denied traffic
// 
AzureNetworkAnalytics_CL| extend NSGRuleAction=split(NSGRules_s,'|',3)[0]| extend NSGRuleName=tostring(split(NSGRules_s,'|',1)[0])| extend NSGName=tostring(split(NSGList_s,'/',2)[0])| where NSGRuleAction == "D" | summarize count() by SourceIP=SrcIP_s, DestinationIP=DestIP_s, DestinationPort=DestPort_d, TimeGenerated, NSGName, NSGRuleName, SourceSubnet=Subnet1_s, DestinationSubnet=Subnet2_s
// 
// Intra vNet allowed traffic for a specific rule
// 
AzureNetworkAnalytics_CL| extend NSGRuleAction=split(NSGRules_s,'|',3)[0]| extend NSGRuleName=tostring(split(NSGRules_s,'|',1)[0])
| extend NSGName=tostring(split(NSGList_s,'/',2)[0])
| where NSGRuleAction == "A"
| where NSGRuleName == "privateipinbound-allow" 
| where SrcIP_s contains "10.20."
| where DestIP_s contains "10.24."
| summarize count() by SourceIP=SrcIP_s, DestinationIP=DestIP_s, DestinationPort=DestPort_d, TimeGenerated, NSGName, NSGRuleName, SourceSubnet=Subnet1_s,     DestinationSubnet=Subnet2_s, L4Protocol_s
```

# Policy Initiatives

Microsoft Defender for Cloud applies **security initiatives** to your subscriptions. Initiatives contain one or more **security policies**. Each of those policies results in a **security recommendation** for improving your security.

An **Azure Policy** definition, created in Azure Policy, is a rule about specific security conditions that you want controlled.

The following policies should be activated:

- Microsoft cloud security benchmark
- Azure CIS 1.3.0
- ZEISS Security Baseline - Azure Security Center
- ZEISS Security Baseline - Subscription Basic 		
- ZEISS Security Baseline - Virtual Machines