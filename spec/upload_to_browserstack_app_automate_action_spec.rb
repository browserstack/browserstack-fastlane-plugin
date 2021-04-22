describe Fastlane::Actions::UploadToBrowserstackAppAutomateAction do
  describe 'Upload to BrowserStack AppAutomate' do
    let(:custom_id) { "customId" }

    it "raises an error if no browserstack_username is given" do
      expect do
        Fastlane::FastFile.new.parse("lane :test do
          upload_to_browserstack_app_automate({})
        end").runner.execute(:test)
      end.to raise_error("No browserstack_username given.")
    end

    it "raises an error if no browserstack_access_key is given" do
      expect do
        Fastlane::FastFile.new.parse("lane :test do
          upload_to_browserstack_app_automate({
            browserstack_username: 'browserstack_username'
          })
        end").runner.execute(:test)
      end.to raise_error("No browserstack_access_key given.")
    end

    it "raises an error if no file_path is given" do
      expect do
        Fastlane::FastFile.new.parse("lane :test do
          upload_to_browserstack_app_automate({
            browserstack_username: 'browserstack_username',
            browserstack_access_key: 'browserstack_access_key'
          })
        end").runner.execute(:test)
      end.to raise_error("No file found at ''.")
    end

    it "raises an error if no file present at given file_path" do
      expect do
        Fastlane::FastFile.new.parse("lane :test do
          upload_to_browserstack_app_automate({
            browserstack_username: 'browserstack_username',
            browserstack_access_key: 'browserstack_access_key',
            file_path: 'some/random/non/existing/file/path'
          })
        end").runner.execute(:test)
      end.to raise_error("No file found at 'some/random/non/existing/file/path'.")
    end

    it "raises an error if file_path do not have any file extension" do
      expect do
        Fastlane::FastFile.new.parse("lane :test do
          upload_to_browserstack_app_automate({
            browserstack_username: 'browserstack_username',
            browserstack_access_key: 'browserstack_access_key',
            file_path: File.join(FIXTURE_PATH, 'DummyFile1')
          })
        end").runner.execute(:test)
      end.to raise_error('file_path is invalid, only files with extensions ["apk", "ipa", "aab"] are allowed to be uploaded.')
    end

    it "raises an error if file_path have invalid file extension" do
      expect do
        Fastlane::FastFile.new.parse("lane :test do
          upload_to_browserstack_app_automate({
            browserstack_username: 'browserstack_username',
            browserstack_access_key: 'browserstack_access_key',
            file_path: File.join(FIXTURE_PATH, 'DummyFile2.txt')
          })
        end").runner.execute(:test)
      end.to raise_error('file_path is invalid, only files with extensions ["apk", "ipa", "aab"] are allowed to be uploaded.')
    end

    it "raises an error if browserstack credentials are wrong" do
      expect do
        Fastlane::FastFile.new.parse("lane :test do
          upload_to_browserstack_app_automate({
            browserstack_username: 'browserstack_username',
            browserstack_access_key: 'browserstack_access_key',
            file_path: File.join(FIXTURE_PATH, 'HelloWorld.apk')
          })
        end").runner.execute(:test)
      end.to raise_error(/App upload failed!!! Reason :/)
    end

    it "should work with correct params" do
      ENV['BROWSERSTACK_APP_ID'] = nil
      expect(RestClient::Request).to receive(:execute).and_return({ "app_url" => "bs://app_url" }.to_json)
      Fastlane::FastFile.new.parse("lane :test do
          upload_to_browserstack_app_automate({
            browserstack_username: 'browserstack_username',
            browserstack_access_key: 'browserstack_access_key',
            file_path: File.join(FIXTURE_PATH, 'HelloWorld.apk')
          })
        end").runner.execute(:test)

      expect(ENV['BROWSERSTACK_APP_ID']).to eq("bs://app_url")
    end

    it "should work with custom id" do
      ENV['BROWSERSTACK_APP_ID'] = nil
      expect(RestClient::Request).to receive(:execute).and_return({ "app_url" => "bs://app_url", "custom_id" => custom_id, "shareable_id" => "username/#{custom_id}" }.to_json)
      Fastlane::FastFile.new.parse("lane :test do
          upload_to_browserstack_app_automate({
            browserstack_username: 'username',
            browserstack_access_key: 'access_key',
            custom_id: '#{custom_id}',
            file_path: File.join(FIXTURE_PATH, 'HelloWorld.apk')
          })
        end").runner.execute(:test)
      expect(ENV['BROWSERSTACK_APP_ID']).to eq(custom_id)
    end
  end
end
