RSpec.feature 'Log In', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:home_page) { HomePage.new }
  let(:student) { create(:student) }

  before { log_in_page.load }

  it { expect(log_in_page).to be_displayed }
  it { expect(log_in_page).to be_page_visible }
  it { expect(log_in_page).to be_nav_bar_visible }
  it { expect(log_in_page).to be_footer_visible }

  context 'with correct email and password' do
    it 'student logs in' do
      email = student.email
      password = student.password
      log_in_page.login_with(email, password)

      expect(home_page).to be_displayed
      expect(home_page).to be_page_visible
      expect(home_page).to be_nav_bar_for_login_user_visible
      expect(home_page).to be_footer_visible
    end
  end

  context 'with email in uppercase' do
    it 'student logs in' do
      email = student.email.upcase
      password = student.password
      log_in_page.login_with(email, password)

      expect(home_page).to be_displayed
      expect(home_page).to be_page_visible
      expect(home_page).to be_nav_bar_for_login_user_visible
    end
  end

  context 'with nonexistent email' do
    it 'raises an error' do
      email = "student_#{student.email.upcase}"
      password = student.password
      log_in_page.login_with(email, password)

      expect(log_in_page).to be_displayed
      expect(log_in_page).to be_page_visible
      expect(log_in_page).to be_nav_bar_visible
      expect(log_in_page).to have_content('Something was wrong with your login information')
      expect(log_in_page).to be_footer_visible
    end
  end

  context 'with empty email' do
    it 'raises an error' do
      email = " "
      password = student.password
      log_in_page.login_with(email, password)

      expect(log_in_page).to have_content('Something was wrong with your login information')
    end
  end

  context 'with incorrect password' do
    it 'raises an error' do
      email = student.email.upcase
      password = "pass_#{student.password}"
      log_in_page.login_with(email, password)

      expect(log_in_page).to have_content('Something was wrong with your login information')
    end
  end

  context 'with empty password' do
    it 'raises an error' do
      email = student.email.upcase
      password = " "
      log_in_page.login_with(email, password)

      expect(log_in_page).to have_content('Something was wrong with your login information')
    end
  end
end
