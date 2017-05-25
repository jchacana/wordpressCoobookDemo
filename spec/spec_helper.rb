require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.log_level = :error
  config.server_runner_data_store = :on_disk
  config.server_runner_clear_cookbooks = false
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end


