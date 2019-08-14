# frozen_string_literal: true

class StudentsViewPage < GeneralPage
  set_url '/students'

  STUDENT_CARD_SELECTOR = 'data-qa'

  element :student_title, 'h3.center-align'
  elements :student_cards, "div[#{STUDENT_CARD_SELECTOR}]"
  elements :student_names, 'span.card-title'

  def student_cards_ids
    student_cards.map { |student| student[STUDENT_CARD_SELECTOR].to_i }
  end

  def open_student_profile_for(student_id)
    element = find(:xpath, "//div[@data-qa='#{student_id}']//a[text()='View Profile']")
    element.click
  end

  def page_visible?
    all_visible?(:student_title)
  end
end
