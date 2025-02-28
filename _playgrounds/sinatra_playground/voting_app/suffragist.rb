require 'sinatra'
require 'yaml/store'

Choices = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
}

# Display the voting form
get '/' do
  @title = 'Welcome to the Suffragist!'
  erb :index
end

# Ability to cast a vote
post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote'] # The vote is stored in the params hash
  @store = YAML::Store.new 'votes.yaml' # Store the votes in a YAML file
  @store.transaction do 
    @store['votes'] ||= {} # If there are no votes, create an empty hash
    @store['votes'][@vote] ||= 0 # If there are no votes for this choice, set it to 0
    @store['votes'][@vote] += 1 # Increment the vote count
  end
  erb :cast
end

# Display the results
get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yaml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end