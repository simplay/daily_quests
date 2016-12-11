source 'https://rubygems.org'

# Use Rails Database Migrations in non Rails projects.
gem 'standalone_migrations'

# Allows Ruby programs to interface with the SQLite3 database engine.
# Installation: `sudo apt-get install sqlite3`
gem 'sqlite3'

# Rack Middleware for handling Cross-Origin Resource Sharing
gem 'rack-cors'

# A micro-framework for creating REST-like APIs
gem 'grape'

#provides an autogenerated documentation for a Grape API
gem 'grape-swagger'

# A documentation generation tool
gem 'yard'

# for keeping track of test coverage
gem 'simplecov', require: false

# for evaluating quality of documentation
gem 'inch', require: false


# for generating coverage report
#gem 'coveralls', require: false


group :development, :test do
  # An IRB alternative and runtime developer console
  gem 'pry'

  # Step-by-step debugging and stack navigation in Pry
  gem 'pry-byebug'

  # enables the user to navigate the call-stack
  gem 'pry-stack_explorer'

  # Pretty prints Ruby objects in color exposing their internal structure with proper indentation
  gem 'awesome_print'

  # Generate Entity-Relationship Diagrams
  gem "rails-erd"
end

group :test do
  # A testing suite faciliting TDD, BDD, mocking, and benchmarking.
  gem 'minitest'

  # A testing API for Rack apps
  gem 'rack-test'

  # Set of strategies for cleaning your database
  gem 'database_cleaner'

  # Keep track of test coverage
  gem "simplecov"

  # Report test-coverage to code climate
  gem "codeclimate-test-reporter", "~> 1.0.0"
end
