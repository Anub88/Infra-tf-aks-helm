# Git Hooks
1. Set up hooks with [this](https://pre-commit.com) framework.
2. Add a `.pre-commit-config.yaml` file for the repository you want to apply hooks to.
3. Install the hooks with `pre-commit install`

## Formatting
```
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v2.3.0
    hooks:
    -   id: debug-statements
        exclude: ^tests/fixtures/example-code/invalid-syntax.py$
    -   id: end-of-file-fixer
    -   id: trailing-whitespace
        exclude: ^tests/fixtures/diffs/
-   repo: https://github.com/psf/black
    rev: 20.8b1
    hooks:
    -   id: black
        args: [--line-length=78]
        files: ^src/
-   repo: https://github.com/pre-commit/mirrors-mypy
    rev: v0.720
    hooks:
    -   id: mypy
        exclude: ^(docs/|example-plugin/|tests/fixtures)

```
## Tagging with Yor

```
repos:
  - repo: https://github.com/bridgecrewio/yor
    rev: 0.1.158
    hooks:
      - id: yor
        name: yor
        entry: yor tag --directory infrastructure/
        args: ["."]
        language: golang
        types: [terraform]
        pass_filenames: false
```