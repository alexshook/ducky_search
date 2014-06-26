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
  # @results = JSON.parse(DuckySearch::Scraper.new.scrape_duck_duck_go(@query))
  @results = DuckySearch::Scraper.new.scrape_duck_duck_go(@query).to_json
  # call JSON.parse() on @results = DuckySearch::Scraper.new.scrape_duck_duck_go(@query).to_json to display readable
  binding.pry

  erb :index
end
