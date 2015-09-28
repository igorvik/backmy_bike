class HomePage < AbstractPage

  def initialize(driver)
    super(driver)
  end

  def getResultPage
    @@driver.find_element(:xpath, './/*[@href="/bikes"]').click
    return ResultPage.new(@@driver)
  end

end

