$LOAD_PATH << '.'
$LOAD_PATH << File.expand_path('../src', __FILE__)
$LOAD_PATH << File.expand_path('../src/api', __FILE__)

module API
end

require 'rubygems'
require 'standalone_migrations'
require 'yaml'
require 'grape'
require 'grape-swagger'

# src and api files
require 'quest'
require 'quests_v1'

connection_details = YAML::load(File.open('db/config.yml'))
ActiveRecord::Base.establish_connection(connection_details['development'])
