# browserstack-fastlane-plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-browserstack)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `Fastlane-plugin-Browserstack`, add it to your project by running:

```bash
fastlane add_plugin browserstack
```

## About

Uploads IPA and APK files to BrowserStack for automation and manual testing.

## Documentation

Refer [App Automate](https://www.browserstack.com/app-automate/appium/fastlane) and [App Live](https://www.browserstack.com/app-live/fastlane) for more information on using this plugin.


## Example

Please refer this [sample android project](https://github.com/browserstack/browserstack-android-sample-app), which demonstrates the use of this plugin.
You can easily upload your app using [BrowserStack Faslane Plugin](https://rubygems.org/gems/fastlane-plugin-browserstack) and execute your test on BrowserStack cloud. In order to configure the plugin add below action in your Fastfile. You can also check our [repository](https://github.com/browserstack/browserstack-fastlane-plugin).
```
upload_to_browserstack_app_automate(
  browserstack_username: ENV["BROWSERSTACK_USERNAME"],
  browserstack_access_key: ENV["BROWSERSTACK_ACCESS_KEY"],
  file_path: "browserstack_android_sample/build/outputs/apk/debug/browserstack_android_sample-debug.apk",
  custom_id: "<custom_id_name>"
)
```
```
Note: custom_id is optional. You can upload multiple builds under the same custom_id.   
Use custom_id in 'app' capability for Appium to always pick the last uploaded build.   
The file_path parameter is not required if the app was built in the same lane with the help of Gradle or Gym plugin.
```

For uploading your app to AppLive use the following action in the fastfile
```
upload_to_browserstack_app_live(
browserstack_username: ENV["BROWSERSTACK_USERNAME"],
browserstack_access_key: ENV["BROWSERSTACK_ACCESS_KEY"],
file_path: "path_to_apk_or_ipa_file"
)
```
Check out the example [Fastfile](https://github.com/browserstack/browserstack-fastlane-plugin/blob/master/fastlane/Fastfile) to see how to use this plugin. Try it by including that in your project's Fastfile, running `fastlane install_plugins` and `bundle exec fastlane test`. Please refer to this [sample android project](https://github.com/browserstack/browserstack-android-sample-app), which demonstrates the use of this plugin.

Once the app upload is successful, the app id of the app will be stored in an environment variable, "BROWSERSTACK_APP_ID" and it can be accessed in your tests in the following way :
```
String app = System.getenv("BROWSERSTACK_APP_ID"); // Get app id from environment variable.
capabilities.setCapability("app", app); // Add app id to driver capability.
```


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

If you have trouble using plugins, check out the [Plugins Troubleshooting guide](https://docs.fastlane.tools/plugins/plugins-troubleshooting/).

## Using _Fastlane_ Plugins

For more information about how the `Fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _Fastlane_

_Fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [Fastlane.tools](https://fastlane.tools).

