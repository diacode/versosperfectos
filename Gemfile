source 'https://rubygems.org'

gem 'rails', '3.2.22'

gem 'unicorn', group: :production

gem 'mysql2'

gem 'whenever', require: false
gem 'searchkick'
gem 'dotenv-rails'
gem 'sidekiq'
gem 'sidekiq-status'
gem 'foreman'

group :development do
  gem 'capistrano', '~> 3.0'  
  gem 'capistrano-rails',   '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-rvm',   '~> 0.1', require: false
  gem 'capistrano3-unicorn', require: false
  gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'
  gem 'byebug'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'
  gem 'compass-rails'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'haml', '>= 3.1.6'
gem 'haml-rails', '>= 0.3.4', :group => :development
gem 'jbuilder'
gem 'rspec-rails', '>= 2.10.1', :group => [:development, :test]
gem 'factory_girl_rails', '>= 3.3.0', :group => [:development, :test]
gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
gem 'email_spec', '>= 1.2.1', :group => :test
gem 'capybara', '>= 1.1.2', :group => :test
gem 'database_cleaner', '>= 0.7.2', :group => :test
gem 'launchy', '>= 2.1.0', :group => :test
gem 'devise', '>= 2.1.0'
gem 'bootstrap-sass'
gem 'will_paginate', '>= 3.0.3'
gem 'friendly_id', '~> 4.0.9'
gem 'acts-as-taggable-on', '~> 2.3.1'
gem 'carrierwave'
gem 'fog'
gem 'rubyzip'
gem 'rmagick'
gem 'mini_magick'
gem 'bootstrap-datepicker-rails'
gem 'will_paginate-bootstrap'
gem 'quiet_assets', :group => :development
gem 'redactor-rails'
gem 'js-routes'
gem 'nokogiri'
gem 'jcrop-rails'
gem 'select2-rails'
gem 'cocoon'

# Gemas para hacer login/registro desde redes sociales
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

gem 'font-awesome-sass-rails'
gem 'fileuploader-rails', '~> 3.5'

gem 'mediaelement_rails'
gem 'soundmanager-rails'

# Social APIs
gem 'koala' # Facebook gem
gem 'twitter'
gem 'meta-spotify'
gem 'slack-notifier'
