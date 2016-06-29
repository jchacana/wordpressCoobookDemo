require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.log_level = :error

  # Specify the path to a local JSON file with Ohai data (default: nil)
  # config.path = 'ohai:wq.json'

  # Specify the operating platform to mock Ohai data from (default: nil)
  config.platform = 'centos'
  config.version = '6.5'
end

at_exit { ChefSpec::Coverage.report! }
