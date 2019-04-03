RSpec.feature 'Create Course', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:home_page) { HomePage.new }
  let(:view_course_page) { ViewCoursePage.new }
  let(:create_course_page) { CreateCoursePage.new }
  let(:student) { create(:student) }

  before do
    log_in_page.load
    log_in_page.login_with(student.email, student.password)
    create_course_page.load
  end

  context 'when open page' do
    it { expect(create_course_page).to be_displayed }
    it { expect(create_course_page).to be_page_visible }
    it { expect(create_course_page).to be_nav_bar_for_login_user_visible }
    it { expect(create_course_page).to be_footer_visible }
  end

  context 'with valid data' do
    it 'course saved' do
      params_course_data = {
        name: Faker::Educator.course_name,
        short_name: Faker::Lorem.characters(8).upcase,
        description: Faker::Lorem.paragraph_by_chars
      }

      create_course_page.create_course_with(params_course_data)

      expect(view_course_page).to be_displayed
      expect(view_course_page).to be_page_visible
      expect(view_course_page).to be_nav_bar_for_login_user_visible
      course_name = params_course_data[:name]
      course_description = params_course_data[:description]
      expect(view_course_page).to have_content("You have successfully create #{course_name}!")
      expect(view_course_page.course_title.text).to eq course_name
      expect(view_course_page.course_description.text).to eq course_description
      expect(view_course_page).to be_footer_visible
    end
  end

  context 'without course name' do
    it 'raises an error' do
      params_course_data = {
        short_name: Faker::Lorem.characters(8).upcase,
        description: Faker::Lorem.paragraph_by_chars
      }

      create_course_page.create_course_with(params_course_data)

      expect(create_course_page).to have_content('Name can\'t be blank')
      expect(create_course_page).to have_content('Name is too short (minimum is 5 characters)')
    end
  end

  context 'without short name' do
    it 'raises an error' do
      params_course_data = {
        name: Faker::Educator.course_name,
        description: Faker::Lorem.paragraph_by_chars
      }

      create_course_page.create_course_with(params_course_data)

      expect(create_course_page).to have_content('Short name can\'t be blank')
      expect(create_course_page).to have_content('Short name is too short (minimum is 3 characters)')
    end
  end

  context 'without course description' do
    it 'raises an error' do
      params_course_data = {
        name: Faker::Educator.course_name,
        short_name: Faker::Lorem.characters(8).upcase
      }

      create_course_page.create_course_with(params_course_data)

      expect(create_course_page).to have_content('Description can\'t be blank')
      expect(create_course_page).to have_content('Description is too short (minimum is 10 characters)')
    end
  end
end
