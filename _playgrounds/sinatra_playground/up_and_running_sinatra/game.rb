require 'sinatra'


before do
  content_type :txt
  @defeat = {rock: :scissors, paper: :rock, scissors: :paper}
  @throws = @defeat.keys # [:rock, :paper, :scissors]
end

get '/throw/:type' do
  player_throw = params[:type].to_sym
  if !@throws.include?(player_throw)
    halt 403, "You must throw one of the following: #{@throws}"
  end
  
  computer_throw = @throws.sample # Randomly select a throw from the array
  if player_throw == computer_throw
    "You tied with the computer. Try again!"
  elsif computer_throw == @defeat[player_throw]
    "Nicely done; #{player_throw} beats #{computer_throw}!"
  else
    "Ouch; #{computer_throw} beats #{player_throw}. Better luck next time!"
  end
end

# An example way to run this 
# ruby game.rb
# http://localhost:4567/throw/rock

