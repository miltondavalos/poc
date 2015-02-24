require 'watir-webdriver'
require_relative 'helpers/window_manager'
require_relative 'helpers/screenshot'

include WindowManager
include Screenshot

browser = Watir::Browser.new :chrome
browser.window.maximize

Before do
  @browser = browser
end

After do |scenario|
  if scenario.failed?
    take_screenshot(scenario, @browser)
    close_all_windows_except_main(@browser)
  end

  # puts scenario.methods
  # puts scenario.passed?
  # puts scenario.failed?
  # p scenario.feature.methods
  # p scenario.name
  # p scenario.steps
  # p scenario.raw_steps
  # p scenario.gherkin_statement
end

at_exit do
  browser.close
end