require 'sinatra/base'
require 'ostruct'
require 'time'
require 'yaml'

class Blog < Sinatra::Base
  set :root, File.expand_path('../../', __FILE__)
  set :articles, []

  # Loop through all the article files
  Dir.glob "#{root}/articles/*.md" do |file|
    # Parse meta data and content from file
    meta, content = File.read(file).split("\n\n", 2)

    # Load YAML in safe mode but permit Date
    meta_data = YAML.safe_load(meta, permitted_classes: [Date, Time])

    # Generate a metadata object
    article = OpenStruct.new(meta_data)

    # Convert the date to a Time object
    article.date = Time.parse(article.date.to_s)

    # Add the content
    article.content = content

    # Generate a slug for the URL
    article.slug = File.basename(file, '.md')

    # Set up the route
    get "/#{article.slug}" do
      erb :post, :locals => { :article => article }
    end

    # Add the article to the list of articles
    articles << article
  end

  # Sort articles by date, newest first
  articles.sort_by! { |article| article.date }
  articles.reverse!

  get '/' do
    erb :index
  end

  run! if app_file == $0
end
