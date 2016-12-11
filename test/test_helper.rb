require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require 'database_cleaner'

# For debugging purposes
require 'pry'

require_relative '../dq'
require File.dirname(__FILE__) + '/../service'

ENV['RACK_ENV'] = 'test'
include Rack::Test::Methods

connection_details = YAML::load(File.open('db/config.yml'))
ActiveRecord::Base.establish_connection(connection_details['test'])

DatabaseCleaner.strategy = :truncation

# clean the test DB
DatabaseCleaner.clean
