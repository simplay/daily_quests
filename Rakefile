require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks

task :default => :test

task :test do
  require "simplecov"
  SimpleCov.start do
    add_filter "test/"
    add_filter "dq.rb"
    add_filter "service.rb"
  end
  test_path = './test/*'
  test_files =['_test.rb', '_spec.rb']
  Dir.glob(test_files.map { |test_file| test_path + test_file }).each { |fname| require fname }
end

desc "Starts an interactive console loading the complete environment and codebase" 
task :console do
  require_relative 'dq'
  require 'pry'
  Pry.start
end

desc "Generate Yard documentation of project source located at src/"
task :docs do
  system("yardoc --no-private --protected src/*.rb")
  require_relative 'dq'
  require "rails_erd/diagram/graphviz"
  RailsERD::Diagram::Graphviz.create
  puts "Generated UML diagram 'erd.pdf'."
end

desc "Annotate models"
task :annotate do
  system("annotate --model-dir src")
end

# @example: usage examples:
#   run the server on the default port: rake server
#   run the server at port 3000: rake server[3000]
desc "Start a rack server listening at port 9292 or at a given port"
task :server, :port do |t, args|
  port = args[:port]
  postfix = (port.nil?) ? "" : "-p #{port}"
  system("rackup #{postfix}")
end

namespace :db do
  namespace :test do

    desc "Run the migrations on the test database"
    task :migrate do
      system("rake db:migrate RAILS_ENV=test")
    end

    desc "Rollback the migrations on the test database"
    task :rollback do
      system("rake db:rollback RAILS_ENV=test")
    end
  end
end

desc "Setup the whole project"
task :setup do
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:test:migrate"].invoke
end
