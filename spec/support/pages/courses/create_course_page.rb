class CreateCoursePage < GeneralPage
  set_url '/courses/new'

  element :course_header, '.header'
  element :name_input, '#course_name'
  element :short_name_input, '#course_short_name'
  element :description_input, '#course_description'
  element :create_course_button, '[name="button"]'

  def create_course_with(options = {})
    name_input.set(options[:name]) unless options[:name].nil?
    short_name_input.set(options[:short_name]) unless options[:short_name].nil?
    description_input.set(options[:description]) unless options[:description].nil?
    create_course_button.click
  end

  def page_visible?
    all_visible?(:course_header, :name_input, :short_name_input,
      :description_input, :create_course_button)
  end
end
