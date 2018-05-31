require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class BrowserstackHelper
      # class methods that you define here become available in your action
      # as `Helper::BrowserstackHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the browserstack plugin helper!")
      end

      # Uploads file to BrowserStack
      # Params :
      # +browserstack_username+:: BrowserStack's username.
      # +browserstack_access_key+:: BrowserStack's access key.
      # +file_path+:: Path to the file to be uploaded.
      # +api_endpoint+:: BrowserStack's api endpoint, either AppAutomate or AppLive url.
      def self.upload_file(browserstack_username, browserstack_access_key, file_path, api_endpoint)
        url = "https://" + browserstack_username + ":" + browserstack_access_key + "@" + api_endpoint

        begin
          response = RestClient.post(url, file: File.new(file_path, 'rb'))
        rescue RestClient::ExceptionWithResponse => err
          error_response = err.response
        end

        # Return app_url if file was uploaded successfully.
        return JSON.parse(response.to_s)["app_url"] unless response.nil?

        # Give error if upload failed.
        UI.user_error!("App upload failed!!! Reason : " + JSON.parse(error_response.to_s)["error"]) unless error_response.nil?
      end
    end
  end
end
