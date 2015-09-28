require 'rspec-rails'
require 'selenium-webdriver'

class AbstractPage
  @@driver = nil

  def initialize(driver)
    driver.manage.window.maximize
    @@driver = driver
  end

  def navigateTo(link)
    @@driver.navigate.to(link)
    return ResultPage.new(@@driver)
  end

  def quit
    @@driver.quit
  end

  def getPageTitle
    return @@driver.title
  end

end