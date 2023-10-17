**Group Creation:**
- Sign in to the Azure portal or Azure AD admin center.
- Select Azure Active Directory > Groups > All groups > New group.
- Open Azure Active Directory and create a new group.
- On the New Group tab, provide group type, name and description.
- Turn off Azure AD roles can be assigned to the group. This switch is visible to only Privileged Role Administrators and Global Administrators because these are only two roles that can set the switch.
- Make the new group eligible for role assignment
- Select the members and owners for the group. You also have the option to assign roles to the group, but assigning a role isn't required here.
- Add members to the role-assignable group and assign roles.
- After the members and owners are specified, select Create.
- The Create button is at the bottom of the page.
- The group is created with any roles you might have assigned to it.

**Assigning the Resource access to Group:**

Access control (IAM) is the page that you typically use to assign roles to grant access to Azure resources. It's also known as identity and access management (IAM) and appears in several locations in the Azure portal.

- Click Access control (IAM) on a particular resource (ex: VM, api, vnet and etc.).
- Click the Role assignments tab to view the role assignments at this scope.
- Click Add > Add role assignment. If you don't have permissions to assign roles, the Add role assignment option will be disabled.
- The Add role assignment page opens.
- Select the appropriate **role**
On the Roles tab, select a role that you want to use. You can search for a role by name or by description. You can also filter roles by type and category.
- In the Details column, click View to get more details about a role.
- Click Next.
- Find and select the **group**.
- You can type in the Select box to search the group name.
- Click Select to groups to the Members list.
- Click Next.
- Click Review + assign to assign the role.