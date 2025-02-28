# myapp.rb
require 'sinatra'

get '/' do
  'Hello world!, this is a simple sinatra app'
end

get '/about' do
  'About Page:'
end

# gem install sinatra rackup puma
# http://localhost:4567
# must rerun the server after making changes