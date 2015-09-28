class ResultPage < AbstractPage

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

end