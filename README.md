Run phpstan on your project.

## Basic usage

```yaml
on: [push]
name: Test

jobs:
  phpstan:
    name: phpstan
    runs-on: ubuntu-latest
    steps:
      - name: Checkout project
        uses: actions/checkout@v2
      - name: Run phpstan
        uses: actions-x/phpstan@v1
        with:
          directories: src tests
          level: 3
          phpstanVersion: ^0.12
```

None of the parameters are required and phpstan defaults are used.

## Configuration reference

All of the parameters are optional but you may need to specify them depending on your project setup.

- `installComposer` - whether to run `composer install` before running phpstan
    - use `1` (run `composer install`) and `0` (don't run `composer install`)
    - the install command won't run if the directory `vendor` already exists
    - since installing composer is not the main purpose of this actions, there is no fine-tuning for it,
    use different action to install dependencies if you need finer control (in that case you don't have to set this to
    `0` because the install won't run if vendor exists)
    - basically the only scenario where you need to set this to zero is if you install dependencies before running this
    action and you use non-default directory for packages (not `vendor`)
- `phpstanVersion` - you can specify the phpstan version that will be installed for checking, any valid composer version
is accepted, if you plan to use phpstan from your composer dependencies, see `useBundled` config below. If you don't
specify a version the latest available is used
- `useBundled` - if you have phpstan in your dependencies, you can set this to `1` to use it instead of downloading
different version
- `level` - the phpstan level, default is `max` (contrary to phpstan default level `0`)
- `paths` - space separated paths to check, if you don't have the paths set in your config file you may need to set this
config because phpstan needs paths specified either or command line or in config file
- `configPath` - the path to the config file, if you use default config names (`phpstan.neon`, `phpstan.neon.dist`)
you don't need to specify this, phpstan will pick them up automatically
- `arguments` - in case you need any additional phpstan command line config, you can put it here

## Full example:


```yaml
on: [push]
name: Test

jobs:
  phpstan:
    name: phpstan
    runs-on: ubuntu-latest
    steps:
      - name: Checkout project
        uses: actions/checkout@v2
      - name: Run phpstan
        uses: actions-x/phpstan@v1
        with:
          installComposer: 0
          phpstanVersion: ^0.12
          level: 5
          paths: src tests
          configPath: custom-phpstan-config.neon
          useBundled: 1
          arguments: --autoload-file my-custom-autoload.php
```
