=begin
Author:     Yaman Aljazairi
Date:       27.12.2020
Compile:    Method 01: by typing rackup  
            Method 02: by typing ruby app.rb
=end
require 'sinatra'
require 'rubygems' if RUBY_VERSION < '1.9'
require 'rest_client'
require 'json'

# Class TrendingDev inherates Sinatra::Base
class TrendingDev < Sinatra::Base

    # This function parse the JSON-Data into Hash, to get the needed elements out of , and then return Results as JSON
    # @param url :  The URL of the JSON Data
    # @return :     JSON out of Hash
    def hash_json(url)
        # Parsing JSON into Hash
        response_parsed= JSON.parse(RestClient.get "#{url}")
            response_parsed.map do |data|
                {name: data['name'], username: data['username'], type: data['type']}
            end.to_json
    end

    # Homepage Endpoint
    get '/' do
        # "Welcome to my Sinatra Trending-Developers-Program <br>
        # In order to know who are the best Ruby developers, add the following Endpoint to your URL: \\trending"
        send_file 'index.html'
    end
    # Trending Endpoint
    get '/trending' do
        content_type:json
        language = "ruby".to_s
        since = "daily".to_s
        # ============> The Production-API is unfortunately down since october 2020
        # URL= "https://ghapi.huchen.dev/developers?language="+language+"&since="+since

        # ===========> A Test-API from the same developer with JSON test Data
        URL= "https://private-anon-fccb6d71e9-githubtrendingapi.apiary-mock.com/developers?language="+language+"&since="+since

        #calling hash_json function
        hash_json(URL)
    end
end
