#!/usr/bin/env ruby

require './dq'

class Service < Grape::API

  version 'v1', using: :path
  format :json
  prefix :api

  helpers do
    def declared_params
      declared(params, include_missing: false).to_hash
    end
  end

  mount API::QuestsV1

  add_swagger_documentation :format => :json,
    :api_version => 'v1',
    :hide_documentation_path => true

end
