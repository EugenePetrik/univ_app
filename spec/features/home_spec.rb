# frozen_string_literal: true

RSpec.describe 'Home', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:home_page) { HomePage.new }
  let(:student) { create(:student) }
  let!(:course) { create_list(:course, 3) }

  before do
    log_in_page.load
    log_in_page.login_with(student.email, student.password)
    home_page.load
  end

  context 'when open page', tag: 'smoke' do
    it { expect(home_page).to be_displayed }
    it { expect(home_page).to be_page_visible }
    it { expect(home_page).to be_nav_bar_for_login_user_visible }
    it { expect(home_page).to be_footer_visible }

    it 'shows title' do
      expect(home_page.title).to eq(I18n.t('layouts.navigation.tech_university'))
    end

    it 'course cards are displayed' do
      expect(home_page.course_cards.count).to eq 3
    end

    it 'course ids match' do
      expect(home_page.course_cards_ids)
        .to eq([course[0].id, course[1].id, course[2].id])
    end

    it 'course titles match' do
      expect(home_page.course_titles.map(&:text))
        .to match_array([course[0].name, course[1].name, course[2].name])
    end
  end

  context 'when click to enrol link' do
    let(:view_profile_page) { ViewProfilePage.new }

    it 'course enrolled', tag: 'smoke' do
      home_page.course_enroll_with(course[0].id)

      expect(view_profile_page).to be_displayed
      expect(view_profile_page).to be_page_visible
      expect(home_page).to be_nav_bar_for_login_user_visible
      expect(view_profile_page).to have_content(I18n.t('success_enroll': course[0].name))
      expect(home_page).to be_footer_visible
    end
  end

  context 'when click to course info link' do
    let(:view_course_page) { ViewCoursePage.new }

    it 'course info page displayes', tag: 'smoke' do
      home_page.open_course_info_for(course[0].id)

      expect(view_course_page).to be_displayed
      expect(view_course_page).to be_page_visible
      expect(view_course_page).to be_nav_bar_for_login_user_visible
      expect(view_course_page.course_title.text).to eq course[0].name
      expect(view_course_page.course_description.text).to eq course[0].description
      expect(view_course_page).to be_footer_visible
    end
  end
end
