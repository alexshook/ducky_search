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

get '/duckysearch' do
  @query = params[:query].gsub(' ', '+')
  return status 404 if query.nil?
  @results = JSON.parse(DuckySearch::Scraper.new.scrape_duck_duck_go(@query))
  # @results = DuckySearch::Scraper.new.scrape_duck_duck_go(@query)
  binding.pry

  erb :index
end
