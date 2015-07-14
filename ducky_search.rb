module DuckySearch
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
      # get all results by div class, return title, snippet, url
      all('div.result__body').each do |result|
        new_obj = {
          title: result.find('h2.result__title').text,
          url: result.find('h2.result__title a.result__a')[:href]
        }
        results_array << new_obj
      end
      results_array
    end

    def get_topic_summary(query_string)
      results = HTTParty.get("http://api.duckduckgo.com/?q=#{query_string}&format=json")
      abstract = JSON.parse(results)['RelatedTopics'][0]["Result"]
      return abstract.size > 3 ? abstract : "Sorry, a summary is not available for this topic."
    end
  end

end
