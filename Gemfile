source 'https://rubygems.org'
ruby '2.3.7'

#
# rails has a bug with minitest 5.10.
# Fixed with Rails 5.2
# workaround is to downgrade to minitest 5.1
# there are 2 changes
# first in Gemfile.lock
# -    minitest (5.11.3)
# +    minitest (5.1.0)
# then adding the following line
gem 'minitest', '~> 5.1'

gem 'rails', '5.0.7'
gem 'puma', '~> 3.7'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'pg', '0.20'  # restrict version until fix with rails 5.1
gem 'jquery-rails'
gem 'haml'
gem 'haml-rails' # no need to call config.generators
gem 'slugged'
gem 'kaminari'
gem 'bcrypt'

# syntax highlight
gem 'nokogiri'
gem 'redcarpet'
gem 'coderay'

group :development, :test do
  gem 'byebug'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

