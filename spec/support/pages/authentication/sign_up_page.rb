# frozen_string_literal: true

class SignUpPage < GeneralPage
  set_url '/students/new'

  element :sign_up_title, 'h3.header'
  element :name_input, '#student_name'
  element :email_input, '#student_email'
  element :pass_input, '#student_password'
  element :pass_confirm_input, '#student_password_confirmation'
  element :sign_up_button, 'button[name="button"]'

  def page_visible?
    all_visible?(:sign_up_title, :name_input, :email_input, :pass_input,
                 :pass_confirm_input, :sign_up_button)
  end

  def sign_up_with(args)
    name_input.set(args[:name]) unless args[:name].nil?
    email_input.set(args[:email]) unless args[:email].nil?
    pass_input.set(args[:pass]) unless args[:pass].nil?
    pass_confirm_input.set(args[:pass_confirm]) unless args[:pass_confirm].nil?
    sign_up_button.click
  end
end
