require 'spec_helper'

describe 'wordpressCookbookDemo::database' do
  let(:chef_run) { 
    chefrunner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2008R2')
    chefrunner.converge(described_recipe) do
      stub_command('test -f /var/lib/mysql/mysql.sock').and_return(true)
      stub_command("test -d /etc/php-fpm.d || mkdir -p /etc/php-fpm.d").and_return(true)
      stub_command("which nginx").and_return(true)
    end
  }

  it 'include recipes' do
    expect(chef_run).to include_recipe('selinux::disabled')
    expect(chef_run).to_not include_recipe('wordpressCookbookDemo::nginx_server')
    expect(chef_run).to_not include_recipe('wordpressCookbookDemo::app')
  end

  context 'install database' do
    it 'install mysql client' do
      expect(chef_run).to create_mysql_client('default')
    end
  end
end