# frozen_string_literal: true

class ViewProfilePage < GeneralPage
  set_url '/students/{student_id}'

  COURSE_LINK_SELECTOR = 'data-qa'

  element :user_name, :xpath, '(//span[@class="card-title"])[1]'
  element :user_email, :xpath, '(//span[@class="card-title"]/following-sibling::p)[1]'
  element :edit_profile_button, 'a.waves-effect'
  element :course_enroll_title, :xpath, '(//span[@class="card-title"])[2]'
  elements :course_links, "li[#{COURSE_LINK_SELECTOR}] a"

  def click_to_edit_profile_button
    edit_profile_button.click
  end

  def page_visible?
    all_visible?(:user_name, :user_email, :course_enroll_title)
  end
end
