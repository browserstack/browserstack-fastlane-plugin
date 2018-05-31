describe Fastlane::Actions::UploadToBrowserstackAppAutomateAction do
  describe 'Upload to BrowserStack AppAutomate' do
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
      end.to raise_error("file_path is invalid, only files of type apk, ipa and zip are allowed.")
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
      end.to raise_error("file_path is invalid, only files of type apk, ipa and zip are allowed.")
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
      Fastlane::FastFile.new.parse("lane :test do
          upload_to_browserstack_app_automate({
            browserstack_username: ENV['BROWSERSTACK_USERNAME'],
            browserstack_access_key: ENV['BROWSERSTACK_ACCESS_KEY'],
            file_path: File.join(FIXTURE_PATH, 'HelloWorld.apk')
          })
        end").runner.execute(:test)
      expect(ENV['BROWSERSTACK_APP_ID']).to satisfy { |value| !value.to_s.empty? }
    end
  end
end
