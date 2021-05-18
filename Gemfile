source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'rails',        '5.2'
gem 'bcrypt',         '3.1.11'
gem 'faker',          '1.7.3'
gem 'will_paginate',           '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'bootstrap', '~> 4.1.0'
gem 'puma',         '4.3.8'
gem 'sass-rails',   '5.0.6'
gem 'uglifier',     '3.2.0'
gem 'coffee-rails', '4.2.2'
gem 'jquery-rails', '4.3.1'
gem 'turbolinks',   '5.0.1'
gem 'jbuilder',     '2.7.0'
gem 'acts_as_votable', '~> 0.11.1'
gem 'closure_tree'
gem 'font-awesome-rails', '~> 4.7.0.0'
gem 'city-state'
gem 'pg',  '0.18.4'
gem 'avatarly'
gem 'exception_handler'
gem 'omniauth', '~> 1.6.1'
gem 'omniauth-google-oauth2'
gem 'omniauth-linkedin'
gem 'omniauth-twitter'
gem 'jquery-ui-rails'
gem 'mini_magick', '~> 4.5', '>= 4.5.1'
gem 'activestorage', '5.2.0'
gem 'react-rails'
gem "aws-sdk-s3", require: false

group :development, :test do
  gem 'byebug',  '9.0.6', platform: :mri
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
