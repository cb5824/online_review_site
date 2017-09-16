
require 'rails_helper'

describe 'Users interact with boardgame entries' do

    # As an authenticated user
    # I want to add an item
    # So that others can review it
  scenario 'An authenticated user can see the add a boardgame inputes' do
    sign_in_user
    visit boardgames_path
    click_button "Add a game!"

    expect(page).to have_content("Title")
    expect(page).to have_content("Genre")
    expect(page).to have_content("Publisher")
    expect(page).to have_content("Player count")
    expect(page).to have_content("Duration (in minutes)")
    expect(page).to have_content("Price (format xxx.xx)")
  end

  scenario 'An authenticated user fills in valid boardgame information and saves it' do
    sign_in_user
    visit boardgames_path
    click_button 'Add a game!'

    fill_in("Title", :with => 'Betrayal at House on the Hill')
    fill_in("Genre", :with => 'Cooporative')
    fill_in("Publisher", :with => 'Avalon Hill')
    fill_in("Player count", :with => '3-6')
    fill_in("Duration (in minutes)", :with => 60)
    fill_in("Price (format xxx.xx)", :with => 19.99)

    click_button 'Create Boardgame'

    expect(page).to have_content('Boardgame was successfully added.')

  end

  # As an authenticated user
  # I want to view a list of items
  # So that I can pick items to review
  scenario 'An authenticated user on the home page can see a list of entries' do
    game1 = FactoryGirl.create(:boardgame)
    game2 = FactoryGirl.create(:boardgame)
    sign_in_user

    visit boardgames_path

    expect(page).to have_content(game1.title)
    expect(page).to have_content(game2.title)

  end

  # As an authenticated user
  # I want to view the details about an item
  # So that I can get more information about it
  scenario 'an authenticated user views the details for a game' do
    game = FactoryGirl.create(:boardgame)
    sign_in_user

    visit boardgames_path
    click_link(game.title)

    expect(page).to have_content(game.title)
    expect(page).to have_content(game.genre)
    expect(page).to have_content(game.publisher)
    expect(page).to have_content(game.player_count)
    expect(page).to have_content(game.duration)
    expect(page).to have_content(game.msrp)
  end


  # As an authenticated user
  # I want to update an item's information
  # So that I can correct errors or provide new information
  scenario 'a user attempts to edit an existing boardgame entry' do
    game = FactoryGirl.create(:boardgame)
    sign_in_user

    visit boardgames_path
    click_link(game.title)

    click_link('Edit this game')

    expect(page).to have_selector('input#boardgame_title')
    expect(page).to have_selector('input#boardgame_genre')
    expect(page).to have_selector('input#boardgame_publisher')
    expect(page).to have_selector('input#boardgame_player_count')
    expect(page).to have_selector('input#boardgame_duration')
    expect(page).to have_selector('input#boardgame_msrp')
  end

  scenario 'an authenticated user enters new valid info for an existing game' do
    game = FactoryGirl.create(:boardgame)
    sign_in_user

    visit boardgames_path
    click_link(game.title)

    click_link('Edit this game')

    fill_in("Title", :with => 'Betrayal at House on the Hill')
    fill_in("Genre", :with => 'Cooporative')
    fill_in("Publisher", :with => 'Avalon Hill')
    fill_in("Player count", :with => '3-6')
    fill_in("Duration (in minutes)", :with => 60)
    fill_in("Price (format xxx.xx)", :with => 19.99)

    click_button('Save changes')
    expect(page).to have_content('Boardgame was updated successfully')
  end

  # As an authenticated user
  # I want to delete an item
  # So that no one can review it
  scenario 'an authenticated user deletes a game entry' do
    game = FactoryGirl.create(:boardgame)
    sign_in_user

    visit boardgames_path
    click_link(game.title)
    click_link('Edit this game')
    click_link('Delete Game')

    expect(page).to have_content('Boardgame deleted successfully')
    expect(page).to_not have_content(game.title)
  end

end
