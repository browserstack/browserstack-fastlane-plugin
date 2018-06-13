source('https://rubygems.org')

gemspec

gem 'rest-client', '~> 2.0', '>= 2.0.2'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
