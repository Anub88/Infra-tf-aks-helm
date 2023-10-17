from setuptools import setup, find_packages

setup(
    name="mlware-data-access-client",
    version="1.1.1",
    description="MLWare client for inference data access",
    author="DBU AI",
    packages=find_packages(),
    author_email="meditec-mlware@zeiss.com",
    install_requires=[
        "pydantic",
        "azure-identity",
        "azure-cosmos",
        "azure-core",
        "azure-data-tables",
        "azure-keyvault-secrets",
        "mlware",
    ],
)
