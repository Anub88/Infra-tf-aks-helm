# Security requirement to Implementation tracking
---
Formally, threat modelling leads to **threats** that are mitigated by **countermeasures**. 
These are modeled and documented in **IRIUS Risk**. 

Countermeasures are then grouped (example: network security) in **countermeasures groups** with each group having a unique Id.

A countermeasure group reflects the security requirements implemented for a single feature in the SWRS security requirement section.

The detailed SWRS items are the user stories. There the individual countermeasures are implemented. The link from userstory to countermeasure is done in IRIUS Risk where the Backlog item is referenced.

_PRS Item -> SWRS Requirement ID -> (Countermeasure Group ID) -> Countermeasure ID -> Userstory_


# Legal Information Endpoint
For displaying/providing simple legal information an APIM policy could be written to respond with hardcoded legal information.
```

# NOTE: For the required meta api that returns adresses and legal stuff the easiest way 
#       is to use an Inbound Processing Policy for APIM:
# <policies>
#     <inbound>
#         <base />
#         <return-response>
#             <set-status code="200" />
#             <set-header name="Content-Type" exists-action="override">
#                 <value>application/json</value>
#             </set-header>
#             <set-body>{
#                 "test_key": "hello"
#             }</set-body>
#         </return-response>
#     </inbound>
#     <backend>
#         <base />
#     </backend>
#     <outbound>
#         <base />
#     </outbound>
#     <on-error>
#         <base />
#     </on-error>
# </policies>

```

