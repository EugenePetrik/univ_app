# frozen_string_literal: true

RSpec.describe 'Help', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:help_page) { HelpPage.new }
  let(:student) { create(:student) }

  before do
    log_in_page.load
    log_in_page.login_with(student.email, student.password)
    help_page.load
  end

  context 'when open page', tag: 'smoke' do
    it { expect(help_page).to be_displayed }
    it { expect(help_page).to be_page_visible }
    it { expect(help_page).to be_nav_bar_for_login_user_visible }
    it { expect(help_page).to be_footer_visible }
  end
end
