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

### ios setup_keychain

```sh
[bundle exec] fastlane ios setup_keychain
```

Setup keychain

### ios update_build_number

```sh
[bundle exec] fastlane ios update_build_number
```



### ios fetch_certificates

```sh
[bundle exec] fastlane ios fetch_certificates
```

Fetch certificates and provisioning profiles

### ios prebuild

```sh
[bundle exec] fastlane ios prebuild
```



### ios build

```sh
[bundle exec] fastlane ios build
```



### ios beta

```sh
[bundle exec] fastlane ios beta
```

Push a new beta build to TestFlight

### ios release

```sh
[bundle exec] fastlane ios release
```

Push a new release build to the App Store

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
