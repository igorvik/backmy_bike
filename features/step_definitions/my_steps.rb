require_relative 'c:/backmy_bike/page_objects/abstract_page.rb'
require_relative 'c:/backmy_bike/page_objects/home_page.rb'
require_relative 'c:/backmy_bike/page_objects/result_page.rb'

browser = nil
result_page = nil
results = nil

Before do
  results = []
  browser = AbstractPage.new(Selenium::WebDriver.for(:firefox))
end

After do
  result_page.quit
end

Given(/^I navigate to (\D+):/) do |page|
  result_page = browser.navigateTo(page)
end

When(/^I write down quantity of picture from the first and last pages/) do
  results.push(result_page.getQuantityOfPictures)
  result_page.getLastPage
  results.push(result_page.getQuantityOfPictures)
end

Then(/^Results should be in a range from 1 to 8 pictures on each page/) do
  results.each do |result|
    (1..8).include?(result).should == true
  end
end