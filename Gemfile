source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails'
gem 'rails', '~> 5.1.4'
gem 'pg'
gem 'activerecord-postgis-adapter'
gem 'puma', '~> 3.7'
gem 'jbuilder', '~> 2.5'
gem 'httparty'
gem 'listen', '>= 3.0.5', '< 3.2'
gem 'rack-cors', :require => 'rack/cors'
gem 'geocoder'

group :development, :test do
  gem 'pry'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "capistrano"
  gem "capistrano-rvm"
  gem "capistrano-rails"
  gem 'slackistrano'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
