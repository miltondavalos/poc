module WindowManager

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
end