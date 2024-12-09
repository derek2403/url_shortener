# Add this line to the top of the file
ENV['RAILS_ENV'] ||= 'development'

require_relative "config/application"

Rails.application.load_tasks

# Remove any database-related tasks if they exist
Rake::Task["db:migrate"].clear if Rake::Task.task_defined?('db:migrate')
Rake::Task["db:setup"].clear if Rake::Task.task_defined?('db:setup')
Rake::Task["db:test:prepare"].clear if Rake::Task.task_defined?('db:test:prepare')
