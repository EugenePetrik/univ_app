class LogInPage < GeneralPage
  set_url '/login'

  element :log_in_title, 'h3.header'
  element :email_input, '#logins_email'
  element :pass_input, '#logins_password'
  element :log_in_button, 'button[name="button"]'

  def page_visible?
    all_visible?(:log_in_title, :email_input, :pass_input, :log_in_button)
  end

  def login_with(email, password)
    email_input.set(email)
    pass_input.set(password)
    log_in_button.click
  end
end
