require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require_relative '../todo.rb'

set :environment, :test

module RSpecMixin
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.order = :random
  Kernel.srand config.seed
end
