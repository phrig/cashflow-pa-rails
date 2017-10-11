require 'capistrano/setup'
require 'capistrano/deploy'
require "capistrano/scm/git"
  install_plugin Capistrano::SCM::Git
require 'capistrano/rails/migrations' # adding /migrations prevents compile_assets from being run.
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'slackistrano/capistrano'

Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }