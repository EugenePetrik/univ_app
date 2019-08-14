# frozen_string_literal: true

class SignUpPage < GeneralPage
  set_url '/students/new'

  element :sign_up_title, 'h3.header'
  element :name, '#student_name'
  element :email, '#student_email'
  element :pass, '#student_password'
  element :pass_confirm, '#student_password_confirmation'
  element :sign_up_button, 'button[name="button"]'

  def sign_up_with(options = {})
    name.set(options[:name]) unless options[:name].nil?
    email.set(options[:email]) unless options[:email].nil?
    pass.set(options[:pass]) unless options[:pass].nil?
    pass_confirm.set(options[:pass_confirm]) unless options[:pass_confirm].nil?
    sign_up_button.click
  end

  def page_visible?
    all_visible?(:sign_up_title, :name, :email, :pass,
                 :pass_confirm, :sign_up_button)
  end
end
