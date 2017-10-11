lock "3.9.1"

set :rvm_ruby_version, "2.3.4"

set :application, "cash_flow_pa"

set :repo_url, "git@github.com:phrig/cash_flow_pa.git"
set :branch, ENV['branch'] || 'master'

set :linked_dirs, %w{tmp}
set :linked_files, %w{config/database.yml config/secrets.yml}

set :slackistrano, {
  channel: '#cheapest_seats_dev',
  webhook: 'https://hooks.slack.com/services/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'
}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :mkdir, "-p", release_path.join('tmp')
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end
