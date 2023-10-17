[[_TOC_]]

# Overview
Enabling security alert emails ensures that security alert emails are received from Microsoft. This ensures that the right people are aware of any potential security issues and are able to mitigate the risk.
You can use Microsoft Defender for cloud to configure email notification settings for security alerts, based on severity and other criteria.
Security alerts need to reach the right people in your organization. By default, Microsoft Defender for Cloud emails subscription owners whenever a high-severity alert is triggered for their subscription.

## Notification types
In the Notification types section, check the Notify about alerts with the following severity (or higher) checkbox.
If the setting checkbox is not selected, the type of security notifications to be sent by Microsoft Defender for Cloud is not configured. 
If the Notify about alerts with the following severity (or higher) is selected but is not set to High, high severity alert notifications are not enabled for Microsoft Defender for Cloud in the selected Azure subscription.
### who should be notified -
Emails can be sent to select individuals or to anyone with a specified Azure role for a subscription.

# Configure the security alerts email notifications through the portal :
Log in to the Azure Portal at https://portal.azure.com.
Navigate to Microsoft Defender for Cloud blade at https://portal.azure.com/#blade/Microsoft_Azure_Security/SecurityMenuBlade/0.
You can send email notifications to individuals or to all users with specific Azure roles.
From Defender for Cloud's Environment settings area, select the relevant subscription, and open Email notifications.
Define the recipients for your notifications with one or both of these options:
From the dropdown list, select from the available roles.
Enter specific email addresses separated by commas. There's no limit to the number of email addresses that you can enter.
To apply the security contact information to your subscription, select Save.

TODO: @Sai, please add this file
![Email_alert.PNG](../.attachments/Email_alert.PNG)






