require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.warning = true
  t.verbose = false
end

task :default => :test
