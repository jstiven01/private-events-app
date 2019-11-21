# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events interface', type: :feature do
  scenario 'Creating an event with logged user' do
    user = User.new(name: 'User Example', email: 'user@example.com')
    user.save
    visit login_path
    fill_in 'Email', with: 'user@example.com'
    click_button 'Sign in'
    visit new_event_path
    expect(page).to have_content('Create an event')
    assert_selector 'form[action="/events"]'
    expect do
      fill_in 'Name', with: 'Event Rails'
      fill_in 'Location', with: 'Singapour'
      fill_in 'Description', with: 'This is an event created by rspec'
      fill_in 'Date', with: '2014/01/01'
      click_button 'Create Event'
    end.to change(Event, :count).by(1)
    expect(page).to have_current_path(event_path(Event.last.id.to_s))
    expect(page).to have_content('Singapour')
    expect(page).to have_content('Event Rails')
  end

  scenario 'redirect to login when No-logged user' do
    user = User.new(name: 'User Example', email: 'user@example.com')
    user.save

    visit new_event_path
    expect(page).to have_current_path(login_path)
  end
end
