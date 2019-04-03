RSpec.feature 'About', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:about_page) { AboutPage.new }
  let(:student) { create(:student) }

  before do
    log_in_page.load
    log_in_page.login_with(student.email, student.password)
    about_page.load
  end

  context 'when open page' do
    it { expect(about_page).to be_displayed }
    it { expect(about_page).to be_page_visible }
    it { expect(about_page).to be_nav_bar_for_login_user_visible }
    it { expect(about_page).to be_footer_visible }
  end
end
