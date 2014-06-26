Capybara.current_driver = :webkit
# Capybara.javascript_driver = :webkit
Capybara.app_host = "https://duckduckgo.com/"

module DuckySearch
  class Scraper
    include Capybara::DSL
    def scrape_duck_duck_go(query_string)
      visit '/'
      fill_in 'q', with: query_string
      # click magnifying class, value='S'
      click_link_or_button 'S'
      # starting return results as JSON
      results_array = []
      results = {}
      # results_length = all('div.result__body').size
      results_length = 20
      result_number = 0
      # get all results by div class, return title and snippet
      all('div.result__body').each do |result|
        new_obj = {
          id: result_number,
          title: result.find('h2.result__title').text,
          content: result.find('div.result__snippet').text
        }
        # new_obj[result.find('h2.result__title').text] = result.find('div.result__snippet').text
        results_array << new_obj
        result_number += 1
        break if result_number == results_length
      end
      return results_array
    end
  end

end
