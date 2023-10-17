[IGA_Datasheet.xlsx](/.attachments/IGA_Datasheet-75f70d5b-8769-43bc-a86b-32f7a71fb98e.xlsx)
[[_TOC_]]

##**Identity Governance & Administration(IGA)**

Identity Governance enables administrators to efficiently manage user identities and access across the entity(project). It improves their visibility into identities and access privileges and helps them implement the necessary controls to prevent inappropriate or risky access. Identity Governance is about visibility, segregation of duties, role management, attestation, analytics and reporting, while Identity Administration is related to account administration, credentials administration, user and device provisioning and managing entitlements.

- ####  **Segregation of Duties (SoD)**

To avoid error and prevent unauthorized, security lapse, security teams can create rules that prevent risky sets of access or transaction rights from being granted to a person. For example, Non operations user handling the production data, unintentionally copies or tampers the data (which is access violation and data security violation). in ideal cases non operations user restricted to access the production data. so, SoD controls should be in place within a given application, as well as across multiple systems and identity access management applications.

- ####  **Access Review**

the process to review and verify user access to various apps and resources. They also simplify access revocation (for example, when a user leaves the organization or moved out of current project).

- ####   **Role-based Access Management**

With role-based access control (RBAC), user access is determined according to their role, so they can only access the information necessary to perform their job duties. By preventing unnecessary access – especially to sensitive data – RBAC increases enterprise security and prevents breaches.

- ####  **Analytics and Reporting**

These IGA provide visibility to user activities and enable security personnel to identify security issues or risks and raise alarms in high-risk situations. They can also suggest security improvements, start remediation processes, address policy violations and generate compliance reports.

 Reporting will help on the security audit on (who, when, why) got the access of the resources.

 ##**Benefits of IGA** 
- ####  **Simplified User Identity Lifecycle Management**

As user associations within the organization change (for example, because they transfer to a different department or leave the organization) access requirements also change. IGA makes it easy to manage these changes, from provisioning to de-provisioning. IGA also helps maintain control over users, devices, networks and other IT resources through password management, permissions management and access requests management.

- ####  **Track Dangerous Access Requests**

An IGA system provides a centralized approval location, making it easy for users to ask for the access approvals they need to fulfill their responsibilities. Centralization also enables administrators to manage permissions, track and detect suspicious activities and prevent potential threat actors from accessing enterprise systems or data. 

Any access request on the production subscription or resources are considered as dangerous access request. which are given on the business need and for limited duration upon approvals of Project Management (on change decision) & Engineering Manager (on change impact)

- ####  **Reporting for Improved Security and Compliance**

Detailed reports and analytics help IT admins to understand what’s happening across the enterprise environment and quickly find any issues or risks. They can then troubleshoot problems to protect business-critical resources. Data centralization also enables admins to audit access reports to meet compliance requirements.

- ####  **Flexible Access Improves User Productivity**

With robust IGA , organizations can safely allow and control remote access to maintain business continuity while also preventing breaches. Such flexibility enables employees to work from anywhere, and thus improve their productivity and performance.

- ####  **Enterprise Scalability**

ensure that employees can access the resources they need, reduce risk and improve compliance. All these benefits allow the organization to scale organically, which they wouldn’t be able to do with manual processes or limited visibility into users, identities and systems.

##**Process**

PO or PL role (requestor) needs to  raise the request(Work item) for new users by providing the user roles which are in line with [IAM](https://dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_wiki/wikis/AIXS%20Platform%20Documentation/8841/IAM).
Respective Admin will act on the Work item and close the task once fulfilled. 

- ####  **Template**


 Workitem : [AIXS Resource Access] New/Change/Delete - username
- [ ] user email :<>
- [ ] User Role  :<>
- [ ] Environments on which access to be provided  :<DEV/QA/STAGE>
- [ ] Requester : <>
 

**_Also, same will be followed while users leaving the project as well to revoke the access_**.

- ####  **Documentation**

All changes in rights and roles of users on Azure and ADO as well as new and removed users are documented in the Workitems in ADO. An additional documentation is also in place in form of an [IGA_Datasheet.xlsx](/.attachments/IGA_Datasheet-c396eaeb-a264-4ffb-aa87-27f5fe8914c1.xlsx) and maintained by PMO.

- ####  **Review**

review the users every 6 months and if any changes in team or in the access, PM or PL will Raise a task for the action. place holder for this meeting also has been shared with respective people

@<20B8DB55-A294-6F59-988B-ECA733E26ABD> 
@<A94500FD-DF61-47CB-B185-ED99155A6F43> 
@<97A4C0D3-6944-42F2-B34F-89FC20E56E93> 
@<A758F28E-94C2-43FB-AB0D-9B91EFCF8915> 
@<784D90E5-D6CF-6583-B966-E6D27BBB309F> 

Review will takes place with reference to the data sheet managed by PM or PL. Admins(owners) of Both Devops & Azure portal will verify the user and access provided. 
