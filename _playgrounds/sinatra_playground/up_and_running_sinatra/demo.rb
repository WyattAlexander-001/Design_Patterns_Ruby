# first  gem install sinatra
# Then gem install thin

require 'sinatra'

get '/' do
  'Hello, world!'
end

# This is a route that will return the contents of the public.html file
# This is a get request, so you can access it by going to http://localhost:4567/public.html
get '/public.html' do
  send_file File.join('public.html')
end

# This is a post request, to see it in action, you can use a tool like Postman
# In postman, you can set the request to POST and the URL to http://localhost:4567

post '/' do
  'Goodbye, world!'
end