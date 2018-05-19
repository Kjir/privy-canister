require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'

configure do
  set :bind, '0.0.0.0'
end

before do
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => %w[OPTIONS GET POST],
          'Access-Control-Allow-Headers' => %w[content-type]
end

options '/todo/item/?' do
  200
end

post '/todo/item/?' do
  request.body.rewind # in case someone already read it
  data = JSON.parse request.body.read
  json item: data['item']
end

get '/todos/?' do
  json todos: [{ item: 'first' }, { item: 'second' }]
end
