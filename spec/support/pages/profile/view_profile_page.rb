class ViewProfilePage < GeneralPage
  set_url '/students/{student_id}'

  element :user_name, :xpath, '(//span[@class="card-title"])[1]'
  element :user_email, :xpath, '(//span[@class="card-title"]/following-sibling::p)[1]'
  element :edit_profile_button, 'a.waves-effect'
  element :course_enroll_title, :xpath, '(//span[@class="card-title"])[2]'
  elements :course_links, '.col.s6.m6 ul li a'

  def click_to_edit_profile_button
    edit_profile_button.click
  end

  def page_visible?
    all_visible?(:user_name, :user_email, :edit_profile_button,
                 :course_enroll_title)
  end
end
