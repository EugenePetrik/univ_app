class StudentsPage
  set_url '/students'

  STUDENT_CARD_SELECTOR = 'data-qa'.freeze

  element :student_title, 'h3.center-align'
  elements :student_cards, "div[#{STUDENT_CARD_SELECTOR}]"

  def student_cards_ids
    student_cards.map { |student| student[STUDENT_CARD_SELECTOR].to_i }
  end

  def open_student_profile_for(student_id)
    element = find(:xpath, "//div[@data-qa='#{student_id}']//a[text()='View Profile']")
    element.click
  end
end
