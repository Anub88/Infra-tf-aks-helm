# Pre-hardened base images
Securing Windows based containers is different from the more common (and sensible) Linux based containers. 
For now, since our platform requires both kinds, the proper configuration of both of them is delegated to a third party. The overhead for securing both kinds is too great to start with.

By using pre-hardened container images, namely pre-hardened according to the CIS benchmark this issue is mitigated. The pre-hardened images can be found in the [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps?search=center%20for%20internet%20security&page=1&filters=partners%3Bpay-as-you-go).

For AI models that require Windows the recommended image is
- [CIS Microsoft Windows Server 2019 Benchmark L2](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/center-for-internet-security-inc.cis-windows-server-2019-v1-0-0-l2?tab=Overview)

For all others is 
- [CIS Ubuntu Linux 20.04 LTS Benchmark L1](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/center-for-internet-security-inc.cis-ubuntu-linux-2004-l1?tab=Overview)

## Cost Estimation
TODO

