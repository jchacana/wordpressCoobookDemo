require 'spec_helper'

describe 'wordpressCookbookDemo::default' do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'centos', version: '6.6').converge(described_recipe) }

  it 'include recipes' do
    expect(chef_run).to include_recipe('wordpressCookbookDemo::nginx_server')
    # expect(chef_run).to include_recipe('wordpressCookbookDemo::database')
  end
end