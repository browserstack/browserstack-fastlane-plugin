require 'fastlane_core/ui/ui'
require 'rest-client'

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
      # +browserstack_custom_id+:: BrowserStacks's custom id.
      # +file_path+:: Path to the file to be uploaded.
      # +url+:: BrowserStack's app upload endpoint.
      def self.upload_file(browserstack_username, browserstack_access_key, browserstack_custom_id, file_path, url)
        begin
          payload = {
            multipart: true,
            file: File.new(file_path, 'rb')
          }

          unless browserstack_custom_id.nil?
            payload[:data] = '{"custom_id": "' + browserstack_custom_id + '"}'
          end

          response = RestClient::Request.execute(
            method: :post,
            url: url,
            user: browserstack_username,
            password: browserstack_access_key,
            payload: payload
          )
        rescue RestClient::ExceptionWithResponse => err
          error_response = err.response
        end

        # Return browserstack_custom_id if it was specified.
        return browserstack_custom_id unless browserstack_custom_id.nil?

        # Return app_url if file was uploaded successfully.
        return JSON.parse(response.to_s)["app_url"] unless response.nil?

        # Give error if upload failed.
        UI.user_error!("App upload failed!!! Reason : " + JSON.parse(error_response.to_s)["error"]) unless error_response.nil?
      end
    end
  end
end
