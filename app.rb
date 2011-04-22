require "sinatra/base"
require "open-uri"
require "json"
require "pp"
require "tropo-webapi-ruby"

module Burn
  class App < Sinatra::Base
    set :raise_errors, true
    set :views, "views"
    set :public, "public"
    set :static, true

    get "/" do
      # Phx, by default.
      redirect "/phx"
    end

    post "/tropo" do
      Tropo::Generator.say "Hello, world"
    end

    get "/sf" do
      response.headers["Cache-Control"] = "public, max-age=300"
      @data = Burn::Sf.new
      if @data.is_spare_the_air_day?
        haml :"burn/sf/spare_the_air_day"
      else
        haml :"burn/sf/clean_air"
      end
    end

    get "/phx" do
      response.headers["Cache-Control"] = "public, max-age=300"
      @data = Burn::Phx.new
      if @data.is_no_burn_day?
        haml :"burn/phx/no_burn_day" # yes, don't burn shit
      else
        haml :"burn/phx/clean_air"   # no, but try not to burn shit anyway
      end
    end

    get "/application.css" do
      response["Content-Type"] = "text/css; charset=utf-8"
      scss :style
    end
  end
end
