# frozen_string_literal: true

class GeneralPage < SitePrism::Page
  # Navigation
  element :brand_logo_title, 'a.brand-logo'
  element :courses_link, :xpath, '(//a[text()="Courses"])[1]'
  element :students_link, :xpath, '(//a[text()="Students"])[1]'
  element :account_link, 'a[data-target="dropdown1"]'
  element :sign_up_link, 'a[href="/students/new"]'
  element :log_in_link, :xpath, '(//a[@href="/login"])[2]'

  section :account_block, 'a[data-target="dropdown1"]' do
    element :your_profile_link, :xpath, '(//a[text()="Your Profile"])[1]'
    element :edit_profile_link, :xpath, '(//a[text()="Edit Profile"])[1]'
    element :log_out_link, :xpath, '(//a[text()="Log Out"])[1]'
  end

  # Footer
  element :brand_logo_footer, :xpath, '//h5[text()="Tech University"]'
  element :information_title, :xpath, '//h5[text()="Information"]'
  element :help_link, 'a[href="/help"]'
  element :about_link, 'a[href="/about"]'
  element :contact_us_link, 'a[href="/contact_us"]'
  element :copyright_title, 'div.grey-text'

  def nav_bar_visible?
    all_visible?(:brand_logo_title, :courses_link, :sign_up_link, :log_in_link)
  end

  def nav_bar_for_login_user_visible?
    all_visible?(:brand_logo_title, :courses_link, :students_link,
                 :account_link)
  end

  def footer_visible?
    all_visible?(:brand_logo_footer, :information_title, :help_link,
                 :about_link, :contact_us_link, :copyright_title)
  end

  private

  def all_visible?(*item_list)
    item_list.all? { |item| send(item).visible? }
  end
end
