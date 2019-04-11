# frozen_string_literal: true

class EditProfilePage < GeneralPage
  set_url '/students/{student_id}/edit'

  element :edit_your_profile_title, 'h3.header'
  element :name_input, '#student_name'
  element :email_input, '#student_email'
  element :pass_input, '#student_password'
  element :pass_confirm_input, '#student_password_confirmation'
  element :sign_up_button, 'button[name="button"]'

  def edit_profile_with(options = {})
    name_input.set(options[:name]) unless options[:name].nil?
    email_input.set(options[:email]) unless options[:email].nil?
    pass_input.set(options[:pass]) unless options[:pass].nil?
    pass_confirm_input.set(options[:pass_confirm]) unless options[:pass_confirm].nil?
    sign_up_button.click
  end

  def page_visible?
    all_visible?(:edit_your_profile_title, :name_input, :email_input,
                 :pass_input, :pass_confirm_input, :sign_up_button)
  end
end
