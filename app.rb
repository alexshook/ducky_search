require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'
require 'json'
require 'httparty'
require 'pry'

require_relative 'ducky_search'

get '/' do
  erb :index
end

get '/search' do
  @query = params[:query].gsub(' ', '+')
  @selection = params[:selection]

  if @selection == 'summary'
    @summary_results = DuckySearch::Scraper.new.get_topic_summary(@query)
  else
    @results = DuckySearch::Scraper.new.scrape_duck_duck_go(@query)
  end
    erb :index
end

get '/:query' do
  content_type :json
  query = params[:query]
  search = DuckySearch::Scraper.new.scrape_duck_duck_go(query).to_json
end
