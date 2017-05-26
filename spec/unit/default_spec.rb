require 'spec_helper'

describe 'wordpressCookbookDemo::default' do
  let(:chef_run) { 
    chefrunner = ChefSpec::ServerRunner.new(platform: 'centos', version: '6.6')
    chefrunner.converge(described_recipe) do
      stub_command('test -f /var/lib/mysql/mysql.sock').and_return(true)
      stub_command("test -d /etc/php-fpm.d || mkdir -p /etc/php-fpm.d").and_return(true)
      stub_command("which nginx").and_return(true)
    end
  }

  it 'include recipes' do
    expect(chef_run).to include_recipe('wordpressCookbookDemo::nginx_server')
    expect(chef_run).to include_recipe('wordpressCookbookDemo::database')
  end
end

