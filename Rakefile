require 'bundler'
Bundler::GemHelper.install_tasks

desc "Open an irb session preloaded with this library"
task :console do
  sh "bundle exec irb -rubygems -I lib -r tassadar.rb"
end

desc "Automatically run specs when files change."
task :"spec:watchr" do
  sh "watchr spec/spec_watchr.rb"
end
