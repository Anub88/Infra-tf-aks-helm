from setuptools import find_packages, setup

setup(
    name="mlware-keyvault-client",
    version="1.0.9",
    description="MLWare keyvault client for secrets, certificates and credentials retrieval",
    author="DBU AI",
    packages=find_packages(),
    author_email="meditec-mlware@zeiss.com",
    install_requires=["azure-identity", "azure-core", "azure-keyvault", "azure-keyvault-certificates", "mlware"],
)
