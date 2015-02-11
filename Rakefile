require "bundler/gem_tasks"

require 'rake/testtask'
require 'rspec/core/rake_task'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'spec'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = false
end


task default: :spec
