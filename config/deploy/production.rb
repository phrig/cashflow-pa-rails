# set :slack_webhook, "https://hooks.slack.com/services/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"
server '35.171.234.200', roles: [:app, :web, :db], user: "ubuntu"
set :deploy_to, '/rails/cashflow-pa-rails'
set :default_env, {
  path: "/home/ubuntu/.rvm/gems/ruby-2.3.4/bin:$PATH"
}
set :branch, ENV["branch"] || "master"
set :ssh_options, {forward_agent: true, keys: "#{ENV['HOME']}/.ssh/projects/cash_flow_pa/cash_flow_pa.pem"}
