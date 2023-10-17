The following description gives advice for a local working environment for python development.


# Python
See the [offical Python docs](https://wiki.python.org/moin/BeginnersGuide/Download) for setting up a Python interpreter.
Use `python 3.9`. This is most recent version currently supported in Azure Functions.

# IDE
The recommendation is to use [Visual Studio Code (VS Code)](https://code.visualstudio.com/download). But any other IDE can be used if you are more comfortable working in it. Be aware that the following sections sometimes assume VSCode beeing the IDE in use.

## Useful Extensions
- (Required) [Python for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
- (Optional) [Thunder Client](https://marketplace.visualstudio.com/items?itemName=rangav.vscode-thunder-client) for testing REST APIs using VS Code (for testing Azure Functions with HTTP triggers/endpoints)
- (Optional) [Behave VSC](https://marketplace.visualstudio.com/items?itemName=jimasp.behave-vsc) for integration test execution
- (Recommended) [Azure Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-node-azure-pack) which includes support for Azure Resources, Azure Functions, etc.
- (Recommended) [Azurite](https://marketplace.visualstudio.com/items?itemName=Azurite.azurite) which is an emulator for Azure Storage, Blob, and Table required as dependency for executing Azure Functions locally
- (Recommended) [Black Formatter](https://marketplace.visualstudio.com/items?itemName=ms-python.black-formatter) to automatically format Python code
- (Optional) [autoDocString](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring) to automatically generate Python docstrings

## Python Virtual Environments
The VS Code project setup (see settings.json) relies on _venv_ as virtual environment. It should be created in the root directory with:
``python3.9 -m venv .venv``

Activate the enviroment with
- (Linux) source .venv/bin/activate
- (Windows) .\venv\Scripts\activate

On Linux you could automatically activate virtual environments when you change into a directory containing one:
```shell
# Automatically source python environments after cd
function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./.venv ]] ; then
        source ./.venv/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi
}
```


## One-line service init (Linux)
This oneliner creates a python **virtual environment**, sets up the required **package indexes** and **installs** all requirements (you either need to change in the folder, in which you find requirements.txt or provide the path to the file).
It can be used for python packages, library code or azure functions.

```bash
python3.9 -m venv .venv;
cd .venv/
echo "[global]
extra-index-url=https://mlware-python-feed:<YOUR-PAT-HERE>@pkgs.dev.azure.com/ZEISSgroup-MED/GEN_Health_Data_Platform/_packaging/mlware-python-feed/pypi/simple/" > pip.conf
cd ..
source .venv/bin/activate
python3.9 -m pip install -r requirements.txt
;
```
PAT is your _Personal Access Token_, which you obtain from the Azure DevOps Enviroment: 
`Account Manager -> More Options -> User Settings`.
Save it.

Use the PAT when Git asks for a password for https://ZEISSgroup-MED@dev.azure.com when cloning a repository.



