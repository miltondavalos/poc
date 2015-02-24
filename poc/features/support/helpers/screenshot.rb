module Screenshot
  def take_screenshot(scenario, browser)
    screenshot = "scenario_#{shot_name(scenario)}_#{shot_postfix}.png"
    path_to_screenshot = "./features/results/#{screenshot}"
    browser.screenshot.save(path_to_screenshot)
    embed screenshot, 'image/png'
  end

  private
  def shot_name(scenario)
    "#{scenario.name.gsub(' ', '_').gsub(/[^0-9A-Za-z_]/, '')}"
  end

  def shot_postfix
    "#{Time.new.day}#{Time.new.hour}#{Time.new.min}#{Time.new.sec}"
  end
end