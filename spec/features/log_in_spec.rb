# frozen_string_literal: true

RSpec.describe 'Log In', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:home_page) { HomePage.new }
  let(:student) { create(:student) }

  before { log_in_page.load }

  context 'when open page', tag: 'smoke' do
    it { expect(log_in_page).to be_displayed }
    it { expect(log_in_page).to be_page_visible }
    it { expect(log_in_page).to be_nav_bar_visible }
    it { expect(log_in_page).to be_footer_visible }
  end

  context 'with correct email and password' do
    let(:view_profile_page) { ViewProfilePage.new }

    it 'student logs in', tag: 'smoke' do
      email = student.email
      password = student.password
      log_in_page.login_with(email, password)

      expect(view_profile_page).to be_displayed
      expect(view_profile_page).to be_page_visible
      expect(view_profile_page).to be_nav_bar_for_login_user_visible
      expect(view_profile_page).to be_footer_visible
    end
  end

  context 'with email in uppercase' do
    let(:view_profile_page) { ViewProfilePage.new }

    it 'student logs in' do
      email = student.email.upcase
      password = student.password
      log_in_page.login_with(email, password)

      expect(view_profile_page).to be_displayed
      expect(view_profile_page).to be_page_visible
      expect(view_profile_page).to be_nav_bar_for_login_user_visible
      expect(view_profile_page).to be_footer_visible
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
      expect(log_in_page).to have_content(I18n.t('logins.create.something_was_wrong'))
      expect(log_in_page).to be_footer_visible
    end
  end

  context 'with empty email' do
    it 'raises an error' do
      log_in_page.login_with(' ', student.password)

      expect(log_in_page).to have_content(I18n.t('logins.create.something_was_wrong'))
    end
  end

  context 'with incorrect password' do
    it 'raises an error' do
      email = student.email.upcase
      password = "pass_#{student.password}"
      log_in_page.login_with(email, password)

      expect(log_in_page).to have_content(I18n.t('logins.create.something_was_wrong'))
    end
  end

  context 'with empty password' do
    it 'raises an error' do
      log_in_page.login_with(student.email.upcase, ' ')

      expect(log_in_page).to have_content(I18n.t('logins.create.something_was_wrong'))
    end
  end
end
