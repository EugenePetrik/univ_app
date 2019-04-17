# frozen_string_literal: true

RSpec.describe 'Create Course', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:home_page) { HomePage.new }
  let(:view_course_page) { ViewCoursePage.new }
  let(:create_course_page) { CreateCoursePage.new }
  let(:student) { create(:student) }
  let(:course) { attributes_for(:course) }

  before do
    log_in_page.load
    log_in_page.login_with(student.email, student.password)
    create_course_page.load
  end

  context 'when open page', tag: 'smoke' do
    it { expect(create_course_page).to be_displayed }
    it { expect(create_course_page).to be_page_visible }
    it { expect(create_course_page).to be_nav_bar_for_login_user_visible }
    it { expect(create_course_page).to be_footer_visible }
  end

  context 'with valid data', tag: 'smoke' do
    it 'course saved' do
      create_course_page.create_course_with(course)

      expect(view_course_page).to be_displayed
      expect(view_course_page).to be_page_visible
      expect(view_course_page).to be_nav_bar_for_login_user_visible
      course_name = course[:name]
      course_description = course[:description]
      expect(view_course_page).to have_content(I18n.t('success_create': course_name))
      expect(view_course_page.course_title.text).to eq course_name
      expect(view_course_page.course_description.text).to eq course_description
      expect(view_course_page).to be_footer_visible
    end

    it 'creates the record in the database' do
      expect do
        create_course_page.create_course_with(course)
      end.to change(Course, :count).by(1)
    end
  end

  context 'without course name' do
    it 'raises an error' do
      create_course_page.create_course_with(name: '')

      expect(create_course_page).to have_content(I18n.t('errors.course.name_is_blank'))
      expect(create_course_page).to have_content(I18n.t('errors.course.name_too_short'))
    end
  end

  context 'with too short course name' do
    it 'raises an error' do
      name = Faker::Lorem.characters(rand(1..4)).upcase

      create_course_page.create_course_with(name: name)

      expect(create_course_page).to have_content(I18n.t('errors.course.name_too_short'))
    end
  end

  context 'with too long course name' do
    it 'raises an error' do
      name = Faker::Lorem.characters(rand(51..100)).upcase

      create_course_page.create_course_with(name: name)

      expect(create_course_page).to have_content(I18n.t('errors.course.name_too_long'))
    end
  end

  context 'without course short name' do
    it 'raises an error' do
      create_course_page.create_course_with(short_name: '')

      expect(create_course_page).to have_content(I18n.t('errors.course.short_name_is_blank'))
      expect(create_course_page).to have_content(I18n.t('errors.course.short_name_too_short'))
    end
  end

  context 'with too short course short name' do
    it 'raises an error' do
      short_name = Faker::Lorem.characters(rand(1..2)).upcase

      create_course_page.create_course_with(short_name: '')

      expect(create_course_page).to have_content(I18n.t('errors.course.short_name_too_short'))
    end
  end

  context 'with too long course short name' do
    it 'raises an error' do
      short_name = Faker::Lorem.characters(rand(16..30)).upcase

      create_course_page.create_course_with(short_name: short_name)

      expect(create_course_page).to have_content(I18n.t('errors.course.short_name_too_long'))
    end
  end

  context 'without course description' do
    it 'raises an error' do
      create_course_page.create_course_with(description: '')

      expect(create_course_page).to have_content(I18n.t('errors.course.desc_is_blank'))
      expect(create_course_page).to have_content(I18n.t('errors.course.desc_too_short'))
    end
  end

  context 'with too short course description' do
    it 'raises an error' do
      description = Faker::Lorem.paragraph_by_chars(rand(1..9))

      create_course_page.create_course_with(description: description)

      expect(create_course_page).to have_content(I18n.t('errors.course.desc_too_short'))
    end
  end

  context 'with too long course description' do
    it 'raises an error' do
      description = Faker::Lorem.paragraph_by_chars(rand(301..350))

      create_course_page.create_course_with(description: description)

      expect(create_course_page).to have_content(I18n.t('errors.course.desc_too_long'))
    end
  end
end
