require 'chefspec'
#require 'chefspec/berkshelf'
#require_relative '../libraries/denodo_helper'
#require_relative '../libraries/denodo_download_helper'
#require_relative 'support/matchers'

RSpec.configure do |config|
  config.log_level = :error

  # Specify the path to a local JSON file with Ohai data (default: nil)
  # config.path = 'ohai.json'

  # Specify the operating platform to mock Ohai data from (default: nil)
  config.platform = 'redhat'
  config.version = '6.4'

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end

at_exit { ChefSpec::Coverage.report! }
