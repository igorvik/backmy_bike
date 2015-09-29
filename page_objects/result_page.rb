class ResultPage < AbstractPage

  searchTerms = nil
  selects = nil
  full_search_results = nil
  simple_search_results = nil

  def initialize(driver)
    super(driver)
  end

  def getQuantityOfPictures
    return @@driver.find_elements(:xpath, '//*[@class="bike bike-item"]').size
  end

  def getLastPage
    if @@driver.find_elements(:xpath, './/*[@class="pagination"]//a').size > 1
      @@driver.find_element(:xpath, './/*[@class="last"]/a').click
    end
    return ResultPage.new(@@driver)
  end

  def getRandomSearchTerms
    searchTerms = []
    if @@driver.find_elements(:css, 'b').size > 0
      for i in 0..4
        @@driver.find_elements(:css, 'b')[i].click
        word = @@driver.find_elements(:css, 'div>#select2-results-'+(i+1).to_s+'>li')[rand(1..@@driver.find_elements(:css, 'div>#select2-results-'+(i+1).to_s+'>li').size-1)]
        searchTerms.push(word.text)
        @@driver.find_elements(:css, 'b')[i].click
      end
    end
    return searchTerms
  end

  def getFullSearchResults(searchTerm)
    selects = []
    full_search_results = []
    @@driver.find_elements(:css, "select").each do |select|
      selects.push(select.attribute("id"))
    end
    for i in 0..4 do
      selected_search = Selenium::WebDriver::Support::Select.new(@@driver.find_element(:css, "#" + selects[i]))
      selected_search.select_by(:text, searchTerm[i])
      sleep 5
      full_search_results.push(@@driver.find_elements(:xpath, '//*[@class="bike bike-item"]').size)
      selected_search.select_by(:text, "Всі")
    end
    return full_search_results
  end

  def getSimpleSearchResults(searchTerms)
    simple_search_results = []
    searchTerms.each do |searchTerm|
      @@driver.find_element(:css, '#search').send_key(searchTerm)
      sleep 5
      simple_search_results.push(@@driver.find_elements(:xpath, '//*[@class="bike bike-item"]').size)
      @@driver.find_element(:css, '#search').clear
      sleep 5
    end
    return simple_search_results
  end

  def clickMoreFieldLink
    @@driver.find_element(:id, 'get_more_field').click
  end

end