require 'rails_helper'

feature "User signs up" do

  scenario "User signs up with correct info" do
    user = FactoryGirl.build(:user)

    visit '/users/sign_up'

    fill_in 'Email', with: user.email
    fill_in 'Name', with: user.name
    fill_in 'Phone number', with: user.phone_number
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password

    click_button 'Sign up'

    page.should have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")

    open_email(user.email)

    current_email.should deliver_to user.email
    current_email.should have_body_text(/You can confirm your account/)
    current_email.should have_body_text(/users\/confirmation\?confirmation/)
    current_email.should have_subject(/Confirmation instructions/)

    click_first_link_in_email
    page.should have_content("Your email address has been successfully confirmed")

    user = User.find_for_authentication(email: user.email)
    user.should be_confirmed
  end

end
