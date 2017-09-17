require 'rails_helper'

describe 'Reviews' do

  # As an unauthenticated user
  # I want to see all the reviews ofr a boardgame
  # So I can have other people's opinions
  scenario 'A user views existing reviews on an item' do
    game = FactoryGirl.create(:boardgame)
    review = FactoryGirl.create(:review, boardgame_id: game.id)

    visit boardgames_path
    click_link(game.title)

    expect(page).to have_content(review.comment)

  end

  # As an authenticated user
  # I want to add a review
  # So others can have my opinion
  scenario 'An authenticated user adds a new review to an item' do
    sign_in_user
    game = FactoryGirl.create(:boardgame)

    visit boardgames_path
    click_link(game.title)
    select '6', from: 'Rating'
    fill_in('Comment', :with => 'This is a pretty solid game. Not my favorite but it deserves a place on my shelf')
    click_button('Create Review')

    expect(page).to have_content('Review saved successfully')
    expect(page).to have_content('This is a pretty solid game')
  end

  # As an authenticated user
  # I want to update a review I posted
  # So I may correct errors
  scenario 'An authenticated user updates a review they posted' do
    sign_in_user
    game = FactoryGirl.create(:boardgame)

    visit boardgames_path
    click_link(game.title)

    select '8', from: 'Rating'
    fill_in('Comment', :with => 'Love it, one of my favs')
    click_button('Create Review')

    click_link('Edit this review')
    select '6', from: 'Rating'
    fill_in('Comment', :with => 'This is a pretty solid game. Not my favorite but it deserves a place on my shelf')
    click_button('Update Review')

    expect(page).to have_content('Review updated')
    expect(page).to have_content('This is a pretty solid game')
  end

  # As an authenticated user
  # I want to delete a review I posted
  # So nobody can see it
  scenario 'An authenticated user deletes a review they posted' do
    sign_in_user
    game = FactoryGirl.create(:boardgame)

    visit boardgames_path
    click_link(game.title)

    select '8', from: 'Rating'
    fill_in('Comment', :with => 'Love it, one of my favs')
    click_button('Create Review')
    click_link('Edit this review')
    click_link('Delete review')

    expect(page).to_not have_content('Love it, one of my favs')
  end


end
