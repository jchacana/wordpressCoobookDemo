require 'spec_helper'

describe 'wordpressCookbookDemo::database' do
  let(:shellout) { double('shellout') }
  before do
    allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
    allow(shellout).to receive(:run_command).and_return(shellout)
  end
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set['wordpress']['version'] = 'latest'
      node.set['wordpressCookbookDemo']['instance_name'] = 'test'
      node.set['wordpress']['db']['name'] = 'test_db'
      node.set['wordpress']['db']['user'] = 'fake_user'
    end
    runner.converge(described_recipe) doin master
      stub_command('test -f /var/lib/mysql/mysql.sock').and_return(true)
    end
  end
  let(:node) { chef_run.node }

  context 'mysql install' do
    it 'should install mysql_client' do
      expect(chef_run).to create_mysql_client('default')
      expect(chef_run).to install_mysql2_chef_gem('default')
    end
  end

  context 'mysql_service' do
    it 'should conf database' do
      expect(chef_run).to create_mysql_service('mysql_wordpress')
    end
  end
  context 'testing symbol link' do
    it 'should has link' do
      expect(chef_run).to_not create_link('/var/lib/mysql/mysql.sock')
    end
  end

  context 'settings database' do
    it 'should create database' do
      expect(chef_run).to create_mysql_database('test_db')
    end
    it 'should create user for db' do
      expect(chef_run).to create_database_user('fake_user')
    end
  end
end
