# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :sidekiq do
  desc 'start sidekiq'
  task :start do
    sh "bundle exec sidekiq -C config/sidekiq.yml"
  end
end

namespace :jobs do
  task work: ["sidekiq:start"]
end
