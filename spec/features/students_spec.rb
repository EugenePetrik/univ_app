RSpec.feature 'Students', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:studets_page) { StudentsViewPage.new }
  let(:profile_page) { ViewProfilePage.new }
  let!(:student1) { create(:student, courses: [course3, course4, course1]) }
  let!(:student2) { create(:student, courses: [course1, course1]) }
  let!(:student3) { create(:student) }
  let(:course1) { create(:course) }
  let(:course2) { create(:course) }
  let(:course3) { create(:course) }
  let(:course4) { create(:course) }

  before do
    log_in_page.load
    log_in_page.login_with(student1.email, student1.password)
    studets_page.load
  end

  context 'when open students page' do
    it { expect(studets_page).to be_displayed }
    it { expect(studets_page).to be_page_visible }
    it { expect(studets_page).to be_nav_bar_for_login_user_visible }
    it { expect(studets_page).to be_footer_visible }

    it 'the number of students equal 3' do
      expect(studets_page.student_cards.count).to eq 3
    end

    it 'student ids match' do
      expect(studets_page.student_cards_ids)
        .to eq([student1.id, student2.id, student3.id])
    end

    it 'student names match' do
      expect(studets_page.student_names.map(&:text))
        .to match_array([student1.name, student2.name, student3.name])
    end
  end

  context 'when open profile page for student without courses' do
    it 'courses are not displayed' do
      studets_page.open_student_profile_for(student3.id)

      expect(profile_page).to be_displayed
      expect(profile_page).to be_page_visible
      expect(profile_page).to be_nav_bar_for_login_user_visible
      expect(profile_page.user_name.text).to eq student3.name
      expect(profile_page.user_email.text).to eq student3.email
      expect(profile_page.course_links.count).to eq 0
      expect(profile_page).to have_content('None')
      expect(profile_page).to be_footer_visible
    end
  end

  context 'when open profile page for student with courses' do
    it 'courses are displayed' do
      studets_page.open_student_profile_for(student1.id)

      expect(profile_page.course_links.count).to eq 3
      expect(profile_page.course_links.map(&:text))
        .to match_array([course1.name, course3.name, course4.name])
    end
  end

  context 'when open own student profile page' do
    it 'Edit Profile button is displayed' do
      studets_page.open_student_profile_for(student1.id)

      expect(profile_page).to have_css('a.waves-effect')
    end
  end

  context 'when open profile page for another student' do
    it 'Edit Profile button is not displayed' do
      studets_page.open_student_profile_for(student2.id)

      expect(profile_page).not_to have_css('a.waves-effect')
    end
  end
end
