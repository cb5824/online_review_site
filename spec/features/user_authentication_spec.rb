require 'rails_helper'

describe "user authentication" do
  # As a prospective user
  # I want to create an account
  # So that I can post items and review them
  scenario "A potential user tries to create and account" do
    visit root_path
    click_link "Sign Up"

    expect(page).to have_content("Username")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_content("Password confirmation")

  end

  # As an unauthenticated user
  # I want to sign in
  # So that I can post items and review them
  scenario "an unauthenticated user tries to sign in" do
    visit root_path
    click_link "Sign In"

    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Log in")

  end

# As an authenticated user
# I want to sign out
# So that no one else can post items or reviews on my behalf
  scenario "An authenticated user signs out" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    click_link('Sign Out')
    expect(page).to have_content('Signed out successfully')
    expect(page).to_not have_content('Sign Out')

  end

# As an authenticated user
# I want to update my information
# So that I can keep my profile up to date
  scenario "an authenticated user updates their profile information" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    click_link 'Edit Account Info'
    fill_in 'Email', with: 'different@test.com'
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully')
    user = User.all[0]
    expect(user.email).to eq('different@test.com')
  end

# As an authenticated user
# I want to delete my account
# So that my information is no longer retained by the app
  scenario "an authenticated user deletes their account" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    click_link 'Edit Account Info'
    click_button "Delete my account"
    expect(page).to have_content("Your account has been successfully deleted.")
  end

end
