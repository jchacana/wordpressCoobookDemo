maintainer 'Rafael Avaria'
maintainer_email 'ravaria@nisum.com'
license 'Apache 2.0'
description 'Installs/Configures wordpress '
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
name 'wordpressCoobookDemo'
version '1.0.0'

depends 'mysql', '~> 5.0.0'
depends 'mysql-chef_gem'
depends 'build-essential'
depends 'tar'
depends 'nginx', '~> 2.7.4'
depends 'php-fpm', '~> 0.6.10'
depends 'wordpress', '~> 2.3.0'

%w(centos).each do |os|
  supports os
end
