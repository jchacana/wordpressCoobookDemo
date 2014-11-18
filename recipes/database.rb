include_recipe "mysql::client" unless platform_family?('windows') # No MySQL client on Windows
include_recipe "mysql-chef_gem" # Replaces mysql::ruby

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
::Chef::Recipe.send(:include, Wordpress::Helpers)

node.set_unless['wordpress']['db']['pass'] = secure_password
node.save unless Chef::Config[:solo]

db = node['wordpress']['db']

if is_local_host? db['host']
  include_recipe "mysql::server"

  mysql_connection_info = {
    :host     => 'localhost',
    :username => 'root',
    :password => node['mysql']['server_root_password']
  }

  mysql_database db['name'] do
    connection  mysql_connection_info
    action      :create
  end

  mysql_database_user db['user'] do
    connection    mysql_connection_info
    password      db['pass']
    host          db['host']
    database_name db['name']
    action        :create
  end

  mysql_database_user db['user'] do
    connection    mysql_connection_info
    database_name db['name']
    privileges    [:all]
    action        :grant
  end

end
