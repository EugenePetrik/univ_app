class ViewCoursePage < GeneralPage
  set_url '/courses/{course_id}'

  element :course_title, '.card-title'
  element :course_description, :xpath, "//div[contains(@class, 'card-content')]/p[2]"

  def page_visible?
    all_visible?(:course_title, :course_description)
  end
end
