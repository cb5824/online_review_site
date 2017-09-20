require 'rails_helper'

describe 'Admin' do

  scenario 'An admin views a list of all users' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user, role: 'admin')

    sign_in_specific_user(admin)
    visit boardgames_path
    click_link 'View all users'

    expect(page).to have_content(user.username)
    expect(page).to have_content(user2.username)
  end

  scenario 'An Admin deletes a user' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user, role: 'admin')

    sign_in_specific_user(admin)
    visit boardgames_path
    click_link 'View all users'
    link_message = 'Delete user ' + user.username
    click_link link_message
    expect(page).to have_content('User deleted')
    expect(page).to_not have_content(user.username)
  end

  scenario 'An admin deletes a review that they did not create' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user, role: 'admin')
    boardgame = FactoryGirl.create(:boardgame, user: user)
    review = FactoryGirl.create(:review, boardgame: boardgame)

    sign_in_specific_user(admin)
    visit boardgames_path
    click_link boardgame.title
    click_link 'Delete review'
    expect(page).to have_content('Review deleted')
    expect(page).to_not have_content(review.comment)
  end

  scenario 'An admin deletes a game they did not create' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user, role: 'admin')
    boardgame = FactoryGirl.create(:boardgame, user: user)

    sign_in_specific_user(admin)
    visit boardgames_path
    click_link boardgame.title
    click_link 'Delete this game'
    expect(page).to have_content('Boardgame deleted')
    expect(page).to_not have_content(boardgame.title)
  end
end
