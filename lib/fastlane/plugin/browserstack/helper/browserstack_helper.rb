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
      # +custom_id+:: Custom id for app upload.
      # +file_path+:: Path to the file to be uploaded.
      # +url+:: BrowserStack's app upload endpoint.
      def self.upload_file(browserstack_username, browserstack_access_key, file_path, url, custom_id = nil)
        payload = {
          multipart: true,
          file: File.new(file_path, 'rb')
        }

        unless custom_id.nil?
          payload[:data] = '{ "custom_id": "' + custom_id + '" }'
        end

        headers = {
          "User-Agent" => "browserstack_fastlane_plugin"
        }
        begin
          response = RestClient::Request.execute(
            method: :post,
            url: url,
            user: browserstack_username,
            password: browserstack_access_key,
            payload: payload,
            headers: headers
          )

          response_json = JSON.parse(response.to_s)
          return response_json["app_url"]
        rescue RestClient::ExceptionWithResponse => err
          begin
            error_response = JSON.parse(err.response.to_s)["error"]
          rescue
            error_response = "Internal server error"
          end
          # Give error if upload failed.
          UI.user_error!("App upload failed!!! Reason : #{error_response}")
        rescue StandardError => error
          UI.user_error!("App upload failed!!! Reason : #{error.message}")
        end
      end
    end
  end
end
