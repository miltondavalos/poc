module WindowManager
  # include UtilityFunction

  def on_new_window(&block)
    @browser.windows.last.use do
      @browser.window.maximize
      yield block
    end
  end

  def close_all_windows(browser)
    window = nil
    browser_windows = browser.windows
    begin
      browser_windows.size.downto(1) do |idx|
        window = idx
        # return browser.close if idx == 1
        return close_browser_session(browser) if idx == 1
        browser_windows[idx - 1].close
      end
    rescue Exception => error
      warn "Error deleting window # #{window}. #{error.message}"
    end
  end

  def close_all_windows_except_main(browser)
    window = nil
    browser_windows = browser.windows
    begin
      browser_windows.size.downto(2) do |idx|
        window = idx
        browser_windows[idx - 1].close unless idx == 1
      end
    rescue Exception => error
      warn "Error deleting window # #{window}. #{error.message}"
    end
  end

  def close_browser_session(browser)
    browser.close
  end

  # def take_screenshot(scenario, browser)
  #   screenshot = "scenario_#{UtilityFunction.shot_name(scenario)}_#{UtilityFunction.shot_postfix}.png"
  #   path_to_screenshot = "./features/results/#{screenshot}"
  #   browser.screenshot.save(path_to_screenshot)
  #   embed screenshot, 'image/png'
  # end
  def take_screenshot(scenario, browser)
    screenshot = "scenario_#{shot_name(scenario)}_#{shot_postfix}.png"
    path_to_screenshot = "./features/results/#{screenshot}"
    browser.screenshot.save(path_to_screenshot)
    embed screenshot, 'image/png'
  end

  # # Will store all utilities
  # class UtilityFunction
  #   def self.shot_name(scenario)
  #     "#{scenario.name.gsub(' ', '_').gsub(/[^0-9A-Za-z_]/, '')}"
  #   end
  #
  #   def self.shot_postfix
  #     "#{Time.new.day}#{Time.new.hour}#{Time.new.min}#{Time.new.sec}"
  #   end
  # end

  # # Will store all utilities
  # class UtilityFunction
    def shot_name(scenario)
      "#{scenario.name.gsub(' ', '_').gsub(/[^0-9A-Za-z_]/, '')}"
    end

    def shot_postfix
      "#{Time.new.day}#{Time.new.hour}#{Time.new.min}#{Time.new.sec}"
    end
  # end
end