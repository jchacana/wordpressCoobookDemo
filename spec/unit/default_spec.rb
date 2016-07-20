require 'spec_helper'

describe 'wordpressCookbookDemo::default' do

  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set['wordpress']['version'] = 'latest'
      node.set['wordpressCookbookDemo']['instance_name'] = 'test'
      node.set['wordpress']['db']['name'] = 'test_db'
      node.set['wordpress']['db']['user'] = 'fake_user'
    end
    runner.converge(described_recipe) do
      stub_command('test -f /var/lib/mysql/mysql.sock').and_return(true)
      stub_command('test -d /etc/php-fpm.d || mkdir -p /etc/php-fpm.d').and_return(true)
      stub_command('which nginx').and_return(true)
      stub_command('test -f /var/lib/mysql/mysql.sock').and_return(true)
    end
  end
  

  context 'Recipes' do
    it 'should include required recipes' do
      expect(chef_run).to include_recipe('wordpressCookbookDemo::database')
      expect(chef_run).to include_recipe('wordpressCookbookDemo::nginx_server')
      expect(chef_run).to include_recipe('wordpressCookbookDemo::app')
    end
  end


  context 'database' do
  
    it 'should install mysql_client' do
      expect(chef_run).to create_mysql_client('default')
      expect(chef_run).to install_mysql2_chef_gem('default')
    end

    it 'should configure database' do
      expect(chef_run).to create_mysql_service('mysql_wordpress')
    end
  
    it 'should has link to mysql.sock' do
      expect(chef_run).to_not create_link('/var/lib/mysql/mysql.sock')
    end
 
    it 'should create wordpress database' do
      expect(chef_run).to create_mysql_database('test_db')
    end

    it 'should create user for db and grant access' do
      expect(chef_run).to create_database_user('fake_user')
    end

  end

end