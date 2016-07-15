require 'serverspec'

RSpec.configure do |c|
  if ENV['SERVERSPEC_HTML'] == 'true'
    c.formatter = 'html'
    c.output_stream = File.open('/tmp/busser/serverspec.html', 'w')
  end
end

set :backend, :exec
