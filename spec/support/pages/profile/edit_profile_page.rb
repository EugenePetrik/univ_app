class EditProfilePage < GeneralPage
  set_url set_url '/students/{student_id}/edit'

  element :edit_your_profile_title, 'h3.header'
  element :name_input, '#student_name'
  element :email_input, '#student_email'
  element :pass_input, '#student_password'
  element :pass_confirm_input, '#student_password_confirmation'
  element :sign_up_button, 'button[name="button"]'

  def edit_profile_with(args)
    name_input.set(args[:name]) unless args[:name].nil?
    email_input.set(args[:email]) unless args[:email].nil?
    pass_input.set(args[:pass]) unless args[:pass].nil?
    pass_confirm_input.set(args[:pass_confirm]) unless args[:pass_confirm].nil?
    sign_up_button.click
  end

  def page_visible?
    all_visible?(:edit_your_profile_title, :name_input, :email_input,
                 :pass_input, :pass_confirm_input, :sign_up_button)
  end
end
