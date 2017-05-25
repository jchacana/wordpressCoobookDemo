# frozen_string_literal: true
source 'https://rubygems.org'

# Dependency Managemenet
gem 'berkshelf', '>= 3'
gem 'chef', '~> 12.4'

# Linting
gem 'foodcritic'
gem 'rubocop'

# Test
gem 'chefspec'
gem 'serverspec'

# Test Automation
group :development do
  gem 'guard'
  gem 'guard-foodcritic'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'guard-kitchen'

  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-docker'
end
