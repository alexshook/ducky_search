module DuckySearch
  Capybara.app = App.new
  Capybara.current_driver = :webkit
  Capybara.app_host = "https://duckduckgo.com/"

  class Scraper
    include Capybara::DSL
    def scrape_duck_duck_go(query_string)
      visit '/'
      fill_in 'q', with: query_string
      # click magnifying class, value='S'
      click_link_or_button 'S'
      # starting return results as JSON
      results_array = []
      limit_results = 20
      result_number = 0
      # get all results by div class, return title, snippet, url
      all('div.result__body').each do |result|
        links = []
        new_obj = {
          id: result_number,
          title: result.find('h2.result__title').text,
          content: result.find('div.result__snippet').text,
          url: result.find('h2.result__title a.result__a')[:href]
        }
        results_array << new_obj
        result_number += 1
        break if result_number == limit_results
      end
      return results_array
    end

    def get_topic_summary(query_string)
      results = HTTParty.get("http://api.duckduckgo.com/?q=#{query_string}&format=json")
      abstract = JSON.parse(results)['AbstractText']
      return abstract.size > 3 ? abstract : "Sorry, a summary is not available for this topic."
    end
  end

end
