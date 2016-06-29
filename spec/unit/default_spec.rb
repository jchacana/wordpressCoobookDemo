require 'spec_helper'

describe 'wordpressCookbookDemo::default' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set['wordpress']['version'] = "latest"
    end
    runner.converge(described_recipe) do
      stub_command('test -f /var/lib/mysql/mysql.sock').and_return(true)
      stub_command("test -d /etc/php-fpm.d || mkdir -p /etc/php-fpm.d").and_return(true)
      stub_command("which nginx").and_return(true)
    end
  end


  context 'Recipes' do
    it 'should include required recipes' do
      expect(chef_run).to include_recipe('wordpressCookbookDemo::database')
      expect(chef_run).to include_recipe('wordpressCookbookDemo::nginx_server')
	  expect(chef_run).to include_recipe('wordpressCookbookDemo::app')

    end
  end

end