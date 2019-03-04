class HomePage < GeneralPage
  set_url '/'

  COURSE_CARD_SELECTOR = 'data-qa'.freeze

  element :course_title, 'h3.center-align'
  elements :course_cards, "div[#{COURSE_CARD_SELECTOR}]"

  def course_cards_ids
    course_cards.map { |course| course[COURSE_CARD_SELECTOR].to_i }
  end

  def course_enroll_with(course_id)
    element = find(:xpath, "//div[@data-qa='#{course_id}']//a[text()='Enroll']")
    element.click
  end

  def open_course_info_for(course_id)
    element = find(:xpath, "//div[@data-qa='#{course_id}']//a[text()='Info']")
    element.click
  end
end
