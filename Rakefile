require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

def rspec_tag_options
  return if ENV['WITH_RUBY_BUGS']
  case RUBY_ENGINE
  when 'jruby' then '--tag ~jruby_bug'
  when 'rbx' then '--tag ~rbx_bug'
  end
end

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = rspec_tag_options
end

task :default => :spec
