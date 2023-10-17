from setuptools import setup, find_packages

setup(
    name="mlware-client-acr-docker",
    version="2.0.7",
    description="MLWare client for Azure Container Registry interaction based on docker API",
    author="DBU AI",
    packages=find_packages(),
    author_email="meditec-mlware@zeiss.com",
    install_requires=["docker", "mlware", "mlware-keyvault-client"],
)
