# frozen_string_literal: true

RSpec.describe 'Edit Profile', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:view_profile_page) { ViewProfilePage.new }
  let(:edit_profile_page) { EditProfilePage.new }
  let(:student) { create(:student) }

  before do
    log_in_page.load
    log_in_page.login_with(student.email, student.password)
    edit_profile_page.load(student_id: student.id)
  end

  context 'when open page', tag: 'smoke' do
    it { expect(edit_profile_page).to be_displayed }
    it { expect(edit_profile_page).to be_page_visible }
    it { expect(edit_profile_page).to be_nav_bar_for_login_user_visible }
    it { expect(edit_profile_page).to be_footer_visible }
  end

  context 'with valid data' do
    let(:pass) { Faker::Internet.password }
    let(:params_user_data) do
      {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        pass: pass,
        pass_confirm: pass
      }
    end

    it 'profile saved', tag: 'smoke' do
      edit_profile_page.edit_profile_with(params_user_data)

      expect(view_profile_page).to be_displayed
      expect(view_profile_page).to be_page_visible
      expect(view_profile_page).to be_nav_bar_for_login_user_visible
      expect(view_profile_page).to have_content(I18n.t('students.update.success_updated_profile'))
      expect(view_profile_page.user_name.text).to eq params_user_data[:name]
      expect(view_profile_page.user_email.text).to eq params_user_data[:email]
      expect(view_profile_page).to be_footer_visible
    end
  end

  context 'without editing password' do
    let(:params_user_data) { attributes_for(:student) }

    it 'profile saved', tag: 'smoke' do
      edit_profile_page.edit_profile_with(params_user_data)

      expect(view_profile_page).to have_content(I18n.t('students.update.success_updated_profile'))
      expect(view_profile_page.user_name.text).to eq params_user_data[:name]
      expect(view_profile_page.user_email.text).to eq params_user_data[:email]
    end
  end

  context 'without name' do
    it 'raises an error' do
      edit_profile_page.edit_profile_with(name: '  ')

      expect(view_profile_page).to have_content(I18n.t('errors.student.name_is_blank'))
      expect(view_profile_page).to have_content(I18n.t('errors.student.name_too_short'))
    end
  end

  context 'with too long name' do
    let(:name) { Faker::Lorem.characters(rand(51..100)) }

    it 'raises an error' do
      edit_profile_page.edit_profile_with(name: name)

      expect(view_profile_page).to have_content(I18n.t('errors.student.name_too_long'))
    end
  end

  context 'with too short name' do
    let(:name) { Faker::Lorem.characters(rand(1..4)) }

    it 'raises an error' do
      edit_profile_page.edit_profile_with(name: name)

      expect(view_profile_page).to have_content(I18n.t('errors.student.name_too_short'))
    end
  end

  context 'without email' do
    it 'raises an error' do
      edit_profile_page.edit_profile_with(email: '  ')

      expect(view_profile_page).to have_content(I18n.t('errors.student.email_is_blank'))
      expect(view_profile_page).to have_content(I18n.t('errors.student.invalid_email'))
    end
  end

  context 'with invalid email' do
    let(:email) { "#{Faker::Internet.username}@#{Faker::Internet.domain_word}" }

    it 'raises an error' do
      edit_profile_page.edit_profile_with(email: email)

      expect(view_profile_page).to have_content(I18n.t('errors.student.invalid_email'))
    end
  end

  context 'with different password and password confirmation' do
    let(:params_user_data) do
      {
        pass: Faker::Internet.password,
        pass_confirm: Faker::Internet.password
      }
    end

    it 'raises an error' do
      edit_profile_page.edit_profile_with(params_user_data)

      expect(view_profile_page).to have_content(I18n.t('errors.student.pass_does_not_match'))
    end
  end
end
