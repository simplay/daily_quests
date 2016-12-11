require 'bundler';Bundler.require(:default)

require_relative 'service'
require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options  ]
  end
end

run Rack::Cascade.new [Service]
