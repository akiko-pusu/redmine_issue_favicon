require 'rake/testtask'

namespace :redmine_issue_favicon do
  desc 'Run test for redmine_issue_favicon plugin.'
  task :test do |task_name|
    next unless ENV['RAILS_ENV'] == 'test' && task_name.name == 'redmine_issue_favicon:test'
  end

  Rake::TestTask.new(:test) do |t|
    t.libs << 'lib'
    t.pattern = 'plugins/redmine_issue_favicon/test/**/*_test.rb'
    t.verbose = false
    t.warning = false
  end
end
