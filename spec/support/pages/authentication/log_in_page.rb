# frozen_string_literal: true

class LogInPage < GeneralPage
  set_url '/login'

  element :log_in_title, 'h3.header'
  element :email, '#logins_email'
  element :password, '#logins_password'
  element :log_in_button, 'button[name="button"]'

  def login_with(email, password)
    self.email.set(email)
    self.password.set(password)
    log_in_button.click
  end

  def page_visible?
    all_visible?(:log_in_title, :email, :password, :log_in_button)
  end
end
