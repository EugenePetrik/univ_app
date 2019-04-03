RSpec.feature 'Edit Profile', type: :feature do
  let(:log_in_page) { LogInPage.new }
  let(:view_profile_page) { ViewProfilePage.new }
  let(:edit_profile_page) { EditProfilePage.new }
  let(:student) { create(:student) }

  before do
    log_in_page.load
    log_in_page.login_with(student.email, student.password)
    edit_profile_page.load(student_id: student.id)
  end

  context 'when open page' do
    it { expect(edit_profile_page).to be_displayed }
    it { expect(edit_profile_page).to be_page_visible }
    it { expect(edit_profile_page).to be_nav_bar_for_login_user_visible }
    it { expect(edit_profile_page).to be_footer_visible }
  end

  context 'with valid data' do
    it "profile saved" do
      name = Faker::Name.name
      email = Faker::Internet.email
      pass = pass_confirm =  Faker::Internet.password

      params_user_data = {
        name: name,
        email: email,
        pass: pass,
        pass_confirm: pass_confirm
      }

      edit_profile_page.edit_profile_with(params_user_data)

      expect(view_profile_page).to be_displayed
      expect(view_profile_page).to be_page_visible
      expect(view_profile_page).to be_nav_bar_for_login_user_visible
      expect(view_profile_page).to have_content('You have successfully updated your profile')
      expect(view_profile_page.user_name.text).to eq params_user_data[:name]
      expect(view_profile_page.user_email.text).to eq params_user_data[:email]
      expect(view_profile_page).to be_footer_visible
    end
  end

  context 'without editing password' do
    it "profile saved" do
      params_user_data = {
        name: Faker::Name.name,
        email: Faker::Internet.email
      }

      edit_profile_page.edit_profile_with(params_user_data)

      expect(view_profile_page).to have_content('You have successfully updated your profile')
      expect(view_profile_page.user_name.text).to eq params_user_data[:name]
      expect(view_profile_page.user_email.text).to eq params_user_data[:email]
    end
  end

  context 'without name' do
    it 'raises an error' do
      edit_profile_page.edit_profile_with(name: '  ')

      expect(view_profile_page).to have_content('Name can\'t be blank')
      expect(view_profile_page).to have_content('Name is too short (minimum is 5 characters)')
    end
  end

  context 'with too short name' do
    it 'raises an error' do
      name_length = (1..4).to_a.sample
      name = Faker::Name.initials(name_length)

      edit_profile_page.edit_profile_with(name: name)

      expect(view_profile_page).to have_content('Name is too short (minimum is 5 characters)')
    end
  end

  context 'without email' do
    it 'raises an error' do
      edit_profile_page.edit_profile_with(email: '  ')

      expect(view_profile_page).to have_content('Email can\'t be blank')
      expect(view_profile_page).to have_content('Email is invalid')
    end
  end

  context 'with different password and password confirmation' do
    it 'raises an error' do
      params_user_data = {
        pass: Faker::Internet.password,
        pass_confirm: Faker::Internet.password
      }

      edit_profile_page.edit_profile_with(params_user_data)

      expect(view_profile_page).to have_content('Password confirmation doesn\'t match Password')
    end
  end
end
