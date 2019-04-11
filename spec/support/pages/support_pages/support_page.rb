# frozen_string_literal: true

class SupportPage < GeneralPage
  element :title, 'h3'
  element :description, '.card-content p'

  def page_visible?
    all_visible?(:title, :description)
  end
end
