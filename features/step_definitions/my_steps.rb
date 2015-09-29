require_relative 'c:/backmy_bike/page_objects/abstract_page.rb'
require_relative 'c:/backmy_bike/page_objects/home_page.rb'
require_relative 'c:/backmy_bike/page_objects/result_page.rb'

browser = nil
result_page = nil
results = nil

random_search_terms = nil
simple_search_results = nil
full_search_results = nil

Before do
  results = []
  random_search_terms = []
  simple_search_results = []
  full_search_results = []
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

Given(/^I open (\D+):/) do |page|
  browser = AbstractPage.new(Selenium::WebDriver.for(:firefox))
  result_page = browser.navigateTo(page)
end

And(/^I choose random search term from advanced search/) do
  result_page.clickMoreFieldLink
  random_search_terms = result_page.getRandomSearchTerms
end

When(/^I make searching with advanced search and simple search tools/) do
  full_search_results = result_page.getFullSearchResults(random_search_terms)
  result_page.clickMoreFieldLink
  simple_search_results = result_page.getSimpleSearchResults(random_search_terms)
end

Then(/^Results should be equals/) do
  for i in 0..4
    full_search_results[i].should == simple_search_results[i]
  end
end