# browserstack-fastlane-plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-browserstack)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-browserstack`, add it to your project by running:

```bash
fastlane add_plugin browserstack
```

## About

Uploads IPA and APK files to BrowserStack for automation and manual testing.

## Documentation

Refer [App Automate](https://www.browserstack.com/app-automate/appium/fastlane) and [App Live](https://www.browserstack.com/app-live/fastlane) for more information on using this plugin.


## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by including that in your project's Fastfile, running `fastlane install_plugins` and `bundle exec fastlane test`.

Please refer this [sample android project](https://github.com/browserstack/browserstack-android-sample-app), which demonstrates the use of this plugin.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).

