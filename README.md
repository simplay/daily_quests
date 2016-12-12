# Daily Quests
[![Build Status](https://travis-ci.org/simplay/daily_quests.svg?branch=master)](https://travis-ci.org/simplay/daily_quests)
[![Test Coverage](https://codeclimate.com/github/simplay/daily_quests/badges/coverage.svg)](https://codeclimate.com/github/simplay/daily_quests/coverage)
[![Code Climate](https://codeclimate.com/github/simplay/daily_quests/badges/gpa.svg)](https://codeclimate.com/github/simplay/daily_quests)
[![Inline docs](http://inch-ci.org/github/simplay/daily_quests.svg?branch=master)](http://inch-ci.org/github/simplay/daily_quests)

Backend to organize personal tasks.

This project is licensed under the [MIT License](https://github.com/simplay/daily_quests/blob/master/LICENSE).

## Requirements

+ Ruby 2.3.0
+ RVM (recommended)

## Installation

+ Install SQLite3: `sudo apt-get install sqlite3`
+ Install bundler: `gem install bundler`

## Project Setup

1. Install dependencies and plugins: `bundle`
2. Setup the project: `rake setup`

## Usage

Start the **server**: `rake server`.

In order to browse the service's **API** interactively, open `./dist/index.html`.

Start an interactive **console**: `rake console`.

Run the **tests**: `rake test`.

Generate the **documentation**: `rake docs`.

**Annotate** the model classes: `rake annotate`.

Generate new **Migration**: `rake db:new_migration name=NAME_OF_NEW_MIGRATION`.

## Contributing

1. Fork this repository
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am "Add some feature"`
4. Push to the branch `git push origin my-new-feature`
5. Create new Pull Request (in your forked repository)
