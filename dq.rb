#!/usr/bin/env ruby

# Daily Quest Interface
# 
# Define global project related paths to ease file requirements.
$LOAD_PATH << '.'
$LOAD_PATH << File.expand_path('../src', __FILE__)
$LOAD_PATH << File.expand_path('../src/api', __FILE__)

# Define API namespace
module API
end

# Define global dependencies
require 'rubygems'
require 'standalone_migrations'
require 'yaml'
require 'grape'
require 'grape-swagger'

# Load source code
require 'quest'
require 'time_builder'

# Load API interfaces
require 'quests_v1'

# Setting up the environment
env_index = ARGV.index("-e")
env_arg = ARGV[env_index + 1] if env_index
env = env_arg || 'development'

# Establish connection to database
connection_details = YAML::load(File.open('db/config.yml'))
ActiveRecord::Base.establish_connection(connection_details[env])
