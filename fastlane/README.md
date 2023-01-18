fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios print_system_name

```sh
[bundle exec] fastlane ios print_system_name
```

Print a system name: CI or Local

### ios tests

```sh
[bundle exec] fastlane ios tests
```

Print 'Hello World'

### ios setup_keychain

```sh
[bundle exec] fastlane ios setup_keychain
```

Setup keychain

### ios fetch_certificates

```sh
[bundle exec] fastlane ios fetch_certificates
```

Fetch certificates and provisioning profiles

### ios update_signin_settings

```sh
[bundle exec] fastlane ios update_signin_settings
```

Update Code Signing Settings

### ios update_build_number

```sh
[bundle exec] fastlane ios update_build_number
```



### ios build

```sh
[bundle exec] fastlane ios build
```



### ios upload

```sh
[bundle exec] fastlane ios upload
```



### ios reloase

```sh
[bundle exec] fastlane ios reloase
```

Push a new build to AppStore

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
