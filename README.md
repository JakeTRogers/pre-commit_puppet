# Puppet Development Kit(PDK) Pre-Commit Hooks

This repository contains a set of [pre-commit](https://pre-commit.com/) hooks for use with the [Puppet Development Kit (PDK)](https://puppet.com/docs/pdk/latest/pdk.html). The hooks are designed to be used with Puppet modules and control-repos to ensure that the code is well-formatted, tested, and documented.

## Requirements

- Linux or Mac OS (Windows is not supported)[^1]
- [pre-commit](https://pre-commit.com/index.html#install)
- [pdk](https://www.puppet.com/docs/pdk/3.x/pdk_install.html)

## Installation

1. Ensure that both pre-commit and the pdk are installed and available in your path
2. Add the desired hooks to your `.pre-commit-config.yaml` in the root of the repository
3. run `pre-commit install --install-hooks`

> [!TIP]
> To automate the install of pre-commit hooks when creating or cloning a repository, use git's `init.templateDir` setting. The Pre-commit project's documentation for this process can be found [here](https://pre-commit.com/index.html#pre-commit-init-templatedir).

### Example

To add the `pdk-validate`, `pdk-test-unit`, `pdk-puppet-strings-control-repo` hooks, add the following to your `.pre-commit-config.yaml` file:

```yaml
- repo: https://github.com/JakeTRogers/pre-commit_puppet
  rev: v1.0.0
  hooks:
  - id: pdk-validate
    args: [--puppet-version=7.27.0, --parallel]
  - id: pdk-test-unit
    args: [--puppet-version=7.27.0, --clean-fixtures]
  - id: pdk-puppet-strings-control-repo
    args: [--format=markdown, --out=REFERENCE.md]
```

> [!NOTE]
> Review the [pdk documentation](https://puppet.com/docs/pdk/latest/pdk.html) for more information on the available options for validate and test unit. While the puppet strings documentation can be found [here](https://www.puppet.com/docs/puppet/8/puppet_strings.html).

## Hooks

### `pdk-validate`

Runs `pdk validate` to check the module for common errors in metadata, YAML, Puppet, Ruby, or Tasks.

### `pdk-test-unit`

Runs `pdk test unit` to execute all available unit tests for the module/control-repo.

### `pdk-puppet-strings-control-repo`

Runs `pdk bundle exec puppet strings generate 'site*/**/*.pp' 'site*/**/*.rb'` as a pre-push hook to ensure the control-repo documentation is up to date by checking if the git repo's working directory is dirty.

By default, the documentation is generated as html and written to the `doc` directory. This hook allows you to specify `--format` and `--out` options to change the output format and location.

### `pdk-puppet-strings-module`

Runs `pdk bundle exec puppet strings generate 'manifests/**/*.pp' 'manifests/**/*.rb'` as a pre-push hook to ensure the module documentation is up to date by checking if the git repo's working directory is dirty.

By default, the documentation is generated as html and written to the `doc` directory. This hook allows you to specify `--format` and `--out` options to change the output format and location.

## License

This project is available under the [MIT License](LICENSE).

## Contributing

Please feel free to open an issue or pull request if you have any suggestions or improvements.

[^1]: Windows is not supported because this hook runs the pdk via a bash script.
