namespace :tools do

  desc "Create a passport, which is stored in RAILS_ROOT"
  task :create_passport do

    puts "Please fire up in the console:"
    puts "java -cp #{File.join(RAILS_ROOT,'vendor/hbci4java.jar')}:classes org.kapott.hbci.tools.InitAndTest"
  end
end