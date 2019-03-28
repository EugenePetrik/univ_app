RSpec.feature 'Home', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:home_page) { HomePage.new }
  let(:profile_page) { ViewProfilePage.new }
  let(:course_info) { CourseInfo.new }
  let(:student) { create(:student) }
  let!(:course1) { create(:course) }
  let!(:course2) { create(:course) }
  let!(:course3) { create(:course) }

  before do
    log_in_page.load
    log_in_page.login_with(student.email, student.password)
    home_page.load
  end

  it { expect(home_page).to be_displayed }
  it { expect(home_page).to be_page_visible }
  it { expect(home_page).to be_nav_bar_for_login_user_visible }
  it { expect(home_page).to be_footer_visible }

  context 'when open home page' do
    it 'shows title' do
      expect(home_page.title).to eq 'Tech University'
    end

    it 'the number of courses equal 3' do
      expect(home_page.course_cards.count).to eq 3
    end

    it 'course ids match' do
      expect(home_page.course_cards_ids)
        .to eq([course1.id, course2.id, course3.id])
    end

    it 'course titles match' do
      expect(home_page.course_titles.map(&:text))
        .to match_array([course1.name, course2.name, course3.name])
    end
  end

  context 'when click to enrol' do
    it 'course enrolled' do
      home_page.course_enroll_with(course1.id)

      expect(profile_page).to be_displayed
      expect(profile_page).to be_page_visible
      expect(home_page).to be_nav_bar_for_login_user_visible
      expect(profile_page).to have_content "You have successfully enrolled in #{course1.name}"
      expect(home_page).to be_footer_visible
    end
  end

  context 'when click to course info' do
    it 'courses page displayes' do
      home_page.open_course_info_for(course1.id)

      expect(course_info).to be_displayed
      expect(course_info).to be_page_visible
      expect(course_info).to be_nav_bar_for_login_user_visible
      expect(course_info.course_title.text).to eq course1.name
      expect(course_info.course_description.text).to eq course1.description
      expect(course_info).to be_footer_visible
    end
  end
end
