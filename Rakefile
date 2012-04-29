#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake'
require 'rspec/core/rake_task'

desc "Open an irb session preloaded with this library"
task :console do
  sh "bundle exec irb -rubygems -I lib -r tassadar.rb"
end

desc "Automatically run specs when files change."
task :"spec:watchr" do
  sh "watchr spec/spec_watchr.rb"
end

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['--backtrace']
  # spec.ruby_opts = ['-w']
end

task :default => :spec
