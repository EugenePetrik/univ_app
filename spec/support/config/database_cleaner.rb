# frozen_string_literal: true

RSpec.configure do |config|
  config.before do
    DatabaseCleaner.strategy = if Capybara.current_driver == :rack_test
                                 :transaction
                               else
                                 :truncation
                               end
    DatabaseCleaner.start
  end
end
