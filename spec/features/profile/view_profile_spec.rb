# frozen_string_literal: true

RSpec.describe 'View Profile', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:view_profile_page) { ViewProfilePage.new }
  let(:edit_profile_page) { EditProfilePage.new }
  let(:student) { create(:student, courses: [course1, course2, course3]) }
  let(:course1) { create(:course) }
  let(:course2) { create(:course) }
  let(:course3) { create(:course) }
  let!(:course4) { create(:course) }

  before do
    log_in_page.load
    log_in_page.login_with(student.email, student.password)
    view_profile_page.load(student_id: student.id)
  end

  context 'when open page', tag: 'smoke' do
    it { expect(view_profile_page).to be_displayed }
    it { expect(view_profile_page).to be_page_visible }
    it { expect(view_profile_page).to be_nav_bar_for_login_user_visible }
    it { expect(view_profile_page).to be_footer_visible }

    it 'student name is displayed' do
      expect(view_profile_page.user_name.text).to eq student.name
    end

    it 'student email is displayed' do
      expect(view_profile_page.user_email.text).to eq student.email
    end

    it 'course links are displayed' do
      expect(view_profile_page.course_links.count).to eq 3
    end

    it 'course names match' do
      expect(view_profile_page.course_links.map(&:text))
        .to match_array([course1.name, course2.name, course3.name])
    end
  end

  context 'when click to the edit profile button' do
    it 'edit profile page is displayed', tag: 'smoke' do
      view_profile_page.click_to_edit_profile_button

      expect(edit_profile_page).to be_displayed
      expect(edit_profile_page).to be_page_visible
      expect(edit_profile_page).to be_nav_bar_for_login_user_visible
      expect(edit_profile_page).to be_footer_visible
    end
  end
end
