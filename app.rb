require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'
require 'json'
require 'pry'
require 'httparty'

require_relative 'ducky_search'

get '/' do
  erb :index
end

get '/search' do
  @query = params[:query].gsub(' ', '+')
  return status 404 if @query.nil?
  @results = DuckySearch::Scraper.new.scrape_duck_duck_go(@query).to_json
  # call JSON.parse() on @results = DuckySearch::Scraper.new.scrape_duck_duck_go(@query).to_json to display readable

  binding.pry
  erb :index
end

get '/:query' do
  content_type :json
  query = params[:query]
  search = DuckySearch::Scraper.new.scrape_duck_duck_go(query).to_json
  # @results = search.to_json
  # json({ status: "success", query: query })
  # return status 404 if query.nil?
end
