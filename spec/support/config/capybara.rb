# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'

Capybara.register_driver(:chrome) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    # Enables access to logs with `page.driver.manage.get_log(:browser)`
    loggingPrefs: {
      browser: 'ALL',
      client: 'ALL',
      driver: 'ALL',
      server: 'ALL'
    }
  )

  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('window-size=1600,1268')

  # Run headless by default unless CHROME_HEADLESS specified
  options.add_argument('headless') unless /^(false|no|0)$/.match?(ENV['CHROME_HEADLESS'])

  options.add_argument('disable-gpu')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
    options: options
  )
end

Capybara.configure do |config|
  config.always_include_port = true
  config.asset_host = 'http://localhost:3000'
  config.default_driver = :chrome
  config.default_max_wait_time = 5
  config.enable_aria_label = true
  config.ignore_hidden_elements = true
  config.javascript_driver = :chrome
  config.server = :puma, { Silent: true }
  config.server_port = 54_321
end

Capybara::Screenshot.prune_strategy = { keep: 20 }

Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  meta = example.metadata
  filename = File.basename(meta[:file_path])
  line_number = meta[:line_number]
  "screenshot_#{filename}-#{line_number}"
end

RSpec.configure do |config|
  config.append_after(:each, type: :feature) do
    Capybara.reset_session!
    Capybara.execute_script 'try { localStorage.clear() } catch(err) { }'
    Capybara.execute_script 'try { sessionStorage.clear() } catch(err) { }'
  end
end
