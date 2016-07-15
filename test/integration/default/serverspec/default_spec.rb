require 'helper_spec'

describe service('mysql_wordpress') do
  it { should be_enabled }
end
describe port(8080) do
  it { should be_listening }
end
