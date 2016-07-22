require 'helper_spec'

describe service('mysql_wordpress') do
  it { should_not be_enabled }
end
describe port(80) do
  it { should be_listening }
end

describe file('/var/www/wordpress') do
  it { should be_directory }
end

describe file('/var/www/wordpress/wp-config.php') do
  its(:content) { should match /define\(\'DB_HOST\'\, \'(\d+)\.(\d+)\.(\d+)\.(\d+)\'\);/ }
end

describe command('nginx -v') do
  its(:stderr) { should match /nginx version/ }
end

describe file('/etc/nginx/sites-enabled/wordpress.conf') do
	  it { should be_exists }
	  it { should be_file }
	  its(:content) { should match /listen 80/ }
end

describe package('nginx') do
  it { should be_installed }
end