# Helm related module.

This module manages helm releases that deploy services and resources into the cluster.

### Output structure of helm_release.

The output structure of a helm_release object is not really documented and is the following:
```hcl
helm_release:
    metadata: [
        {
            "name": str
            "revision": str
            "namespace": str
            ...
            "values": str (json encoded)
        }
    ]
    manifest:
```
