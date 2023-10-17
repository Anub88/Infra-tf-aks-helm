[[_TOC_]]

# Working Environment

This section describes how to setup a local work environment including development tools for application development.

## Overview: Local development - Azure and Python
The solution design and application development for MLware platform follows the idea of implementing serverless microservices in Python framework deployed on Azure infrastructure (Azure Functions).



### VS Code debugging
In order to start a debugging session:
- Start VS Code on a Linux environment (see prerequisite): e. g. on a Windows computer, start a remote connection as e. g. ``WSL: Ubunutu``
- Azurite: Start Azurite emulator pressing ``Crtl+Shift+P`` and fill in ``Azurite: Start`` and press enter
- Azure Function Debug Session: ``Press (F5)`` or execute ``Attach to Python Functions`` in ``Run and debug`` menu (``Crtl+Shift+D``)

### Pre-commit hooks
To ensure consistent code quality, pre-commit hooks allow the execution of code on every commit/push etc.
The hook is located in `/application/inference/.pre-commit-config.yaml`. 
It requires https://pre-commit.com/ to be installed. Then do

´´´bash
pre-commit install
´´´

and it should run on every commit. If, for some reason this prevents you from commiting the hook can be skipped with
´´´bash
git commit --no-verify
´´´

### Testing with pytest

Tests are run via pytest. To verify if it works without running tests do ```pytest --collect-only```.
This should list all available tests.

In case of ModuleNotFoundErrors add your root project to your PYTHONPATH. (Make sure your virtual environment is active):

```bash
export PYTHONPATH="${PYTHONPATH}:/path/to/your/project/";
```

To run a certain test do:

```bash
pytest -k TestThisThingFunction
```
VSCode integrates with pytest, select `Python:Configure Tests` and follow the instructions.

### Test Coverage
Test coverage can be evaluated using the tool [pytest-cov](https://pypi.org/project/pytest-cov/) (installation by ``pip install pytest-cov`` in your virtual environment). Be aware of the debugging implications as described [here](https://code.visualstudio.com/docs/python/testing#_pytest-configuration-settings).
To visualize line coverage in VS Code install the [coverage gutters](https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters) extension.

Coverage report generation with: ``pytest --cov-report xml --cov=<project-name> tests/``

### Formatting

For consistent code formatting use **black** as formatter. In VSCode open a .py file and do `Format Document with...` and select black.
Optionally select in the GUI settings

`Python > Formatting: Provider = black`

`Editor > Format On Save = true`

Make sure, you are saving the setting in the Remote[WSL:Ubuntu] and not in User.

### Linting

As of now **pylint** is suggested as a linter. Add it to your requirements (pip install pylint).

In VSCode select *(Ctrl+Shift+P)* `Python: Select Linter` `pylint` and add
`"python.linting.pylintPath": ".venv/bin/pylint"` to your `settings.json`.
Select `Python: Enable/Disable Linting` to activate it. VSCode should now show display hints.

To run the linter from the terminal and generate a report do
```bash
pylint -r=y project_root/
```

### Integration Testing
For integration testing (testing the integration and combination of two or more components, without using test doubles), behaviour driven development (BDD) approaches getting applied.

The testing framework used in this context is [Python behave](https://behave.readthedocs.io/en/stable/).

#### Installation
See the [installation description](https://behave.readthedocs.io/en/stable/install.html), how to setup behave on your local machine.

#### Usage
In the directory ``inference/application`` you can find an ``integration_tests`` directory, which contains the BDD specification of integration tests for all inference applications. Executing the integration tests is either using IDE (VS Code) or run the command ``behave`` from directory where a ``features`` directory is located.


