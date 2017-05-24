
node.normal['php-fpm']['pools'] = []

include_recipe 'php-fpm'

php_fpm_pool 'wordpress' do
  listen '127.0.0.1:9001'
  user node['wordpress']['install']['user']
  group node['wordpress']['install']['group']
  if node['platform'] == 'ubuntu' && node['platform_version'] == '10.04'
    process_manager 'dynamic'
  end
  listen_owner node['wordpress']['install']['user']
  listen_group node['wordpress']['install']['group']
  php_options node['wordpress']['php_options']
  start_servers 5
end

include_recipe 'php::module_mysql'

node.normal['nginx']['default_site_enabled'] = false
include_recipe 'nginx'

include_recipe 'wordpressCookbookDemo::app'

template "#{node['nginx']['dir']}/sites-enabled/wordpress.conf" do
  source 'nginx.conf.erb'
  variables(
    docroot: node['wordpress']['dir'],
    server_name: node['wordpress']['server_name'],
    server_aliases: node['wordpress']['server_aliases'],
    server_port: node['wordpress']['server_port']
  )
  action :create
end

# The following block is specifically for OS's like CentOS that include a
# default site as a part of the install. This block will only be triggered if
# node['nginx']['default_site_enable'] is set to false.
file File.join(node['nginx']['dir'], 'conf.d', 'default.conf') do
  action :delete
  notifies :reload, 'service[nginx]'
  only_if { node['platform_family'] == 'rhel' && !node['nginx']['default_site_enabled'] }
end
