# Azure Container Registry

We are using the Aure Container Registry for pushing and pulling containers.

## Pushing Artifacts

To get started, you need to understand that the containers must be pushed to our public ACR not the private one. In this public ACR, there is a token-based access restriction, which is on a repository level. Therefore, you just need to register to the ACR with those credentials and you can push and pull containers.

To login, you'll need the token name for the repo you want to push to and the password. Those values can be found in the KeyVault. 

Once those are retrieved, you can login with the following command:

`docker login <acr-name>.azurecr.io --username <token-name> --password <password>`
w
Example usage:

`docker login acrpubmlwscicdweus.azurecr.io --username acr-token-acr-scope-map-bsi --password the-actual-password-found-in-keyvault`

Once you're logged in, you can simply push or pull your image with the following command:

`docker push <image id> <acr-name>.azurcr.io/<repository-name>`

Example usage:

`docker push 4d9fb555bd0d acrpubmlwscicdweus.azurecr.io/bsi`

That's it!

## Hint

You can list the image ids with `docker images`

