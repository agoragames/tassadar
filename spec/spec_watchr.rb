ENV["WATCHR"] = "1"
system 'clear'

$spec_cmd = "bundle exec rspec --tty --color --format nested -d"

def run(cmd)
  puts(cmd)
  if system("which growlnotify > /dev/null")
    run_with_notifier :growl, cmd
  elsif system("which notify-send > /dev/null")
    run_with_notifier :libnotify, cmd
  else
    `#{cmd}`
  end
end

def run_with_notifier(notifier, cmd)
  pass = system(cmd)
  if pass
    image = File.join(File.dirname(__FILE__), 'support', 'rails_ok.png')
    message = "Success!"
  else
    image = File.join(File.dirname(__FILE__), 'support', 'rails_fail.png')
    message = "Failure!"
  end

  case notifier
  when :growl
    `growlnotify -n "StarLeagues Specs" -m "StarLeagues Specs" --image #{image} #{message}`
  when :libnotify
    `notify-send --icon #{image} "StarLeagues Specs" #{message}`
  end
end

def run_spec(file)
  system('clear')
  result = run "#{$spec_cmd} #{file}"
  result.split("\n").last rescue nil
  puts result
end

def run_all_specs
  system('clear')
  result = run "#{$spec_cmd} spec/"
  puts result
end

def related_specs(path)
  Dir['spec/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_spec.rb/ }
end

watch('.*') { run_all_specs }

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running all specs ---\n\n"
  run_all_specs
end

@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    # raise Interrupt, nil # let the run loop catch it
    run_all_specs
    @interrupted = false
  end
end

puts "Watching..."
