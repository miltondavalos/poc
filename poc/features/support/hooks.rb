require 'watir-webdriver'
require_relative 'helpers/window_manager'

include WindowManager

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

end

at_exit do
  browser.close
end