require 'fastlane/action'
require_relative '../helper/browserstack_helper'
require 'json'
require 'rest-client'

module Fastlane
  module Actions
    module SharedValues
      BROWSERSTACK_APP_ID ||= :BROWSERSTACK_APP_ID
    end
    class UploadToBrowserstackAppAutomateAction < Action
      SUPPORTED_FILE_EXTENSIONS = ["apk", "ipa", "zip"]
      UPLOAD_API_ENDPOINT = "api-cloud.browserstack.com/app-automate/upload"

      def self.run(params)
        browserstack_username = params[:browserstack_username] # Required
        browserstack_access_key = params[:browserstack_access_key] # Required
        file_path = params[:file_path] # Required

        UI.message("Uploading app to BrowserStack AppAutomate...")

        browserstack_app_id = Helper::BrowserstackHelper.upload_file(browserstack_username, browserstack_access_key, file_path, UPLOAD_API_ENDPOINT)

        # Set 'BROWSERSTACK_APP_ID' environment variable, if app upload was successful.
        ENV['BROWSERSTACK_APP_ID'] = browserstack_app_id

        UI.success("Successfully uploaded app " + file_path + " to BrowserStack AppAutomate with app_url : " + browserstack_app_id)

        UI.success("Setting Environment variable BROWSERSTACK_APP_ID = " + browserstack_app_id)

        # Setting app id in SharedValues, which can be used by other fastlane actions.
        Actions.lane_context[SharedValues::BROWSERSTACK_APP_ID] = browserstack_app_id
      end

      # Validate file_path.
      def self.validate_file_path(file_path)
        UI.user_error!("No file found at '#{file_path}'.") unless File.exist?(file_path)

        # Validate file extension.
        file_path_parts = file_path.split(".")
        unless file_path_parts.length == 2 && SUPPORTED_FILE_EXTENSIONS.include?(file_path_parts[1])
          UI.user_error!("file_path is invalid, only files of type apk, ipa and zip are allowed.")
        end
      end

      def self.description
        "Uploads IPA, APK and ZIP files to BrowserStack AppAutomate for running automated tests."
      end

      def self.authors
        ["Hitesh Raghuvanshi"]
      end

      def self.details
        "Uploads IPA, APK and ZIP files to BrowserStack AppAutomate for running automated tests."
      end

      def self.output
        [
          ['BROWSERSTACK_APP_ID', 'App id of uploaded app.']
        ]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :browserstack_username,
                                       description: "BrowserStack's username",
                                       optional: false,
                                       is_string: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("No browserstack_username given.") if value.to_s.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :browserstack_access_key,
                                       description: "BrowserStack's access key",
                                       optional: false,
                                       is_string: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("No browserstack_access_key given.") if value.to_s.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :file_path,
                                       description: "Path to the app file",
                                       optional: false,
                                       is_string: true,
                                       verify_block: proc do |value|
                                         validate_file_path(value)
                                       end)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :android].include?(platform)
      end

      def self.example_code
        [
          'upload_to_browserstack_app_automate',
          'upload_to_browserstack_app_automate(
            browserstack_username: ENV["BROWSERSTACK_USERNAME"],
            browserstack_access_key: ENV["BROWSERSTACK_ACCESS_KEY"],
            file_path: "path_to_apk_or_ipa_or_zip_file"
           )'
        ]
      end
    end
  end
end
