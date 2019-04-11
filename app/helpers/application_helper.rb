# frozen_string_literal: true

module ApplicationHelper
  def session_link
<<<<<<< 868afc48e0764b9b6c14d1efc3f31f30fa74ae09
    if (logged_in?)
      link_to t('.log_out'), logout_path, method: :delete
=======
    if logged_in?
      link_to 'Log Out', logout_path, method: :delete
>>>>>>> Add rubocop-rspec gem
    else
      link_to t('.log_in'), login_path
    end
  end
end
