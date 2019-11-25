# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events interface', type: :feature do
  let(:user_creator) { User.create(name: 'usercreator', email: 'usercreator@example.com') }
  let(:user1) { User.create(name: 'user1', email: 'user1@example.com') }
  let(:user2) { User.create(name: 'user2', email: 'user2@example.com') }
  let(:user3) { User.create(name: 'user3', email: 'user3@example.com') }

  let(:event) do
    Event.create(name: 'event1', location: 'somewhere',
                 date_event: '2015/1/9-18:10', creator: user_creator)
  end

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

  scenario 'Event’s Show page display a list of attendees' do
    user = User.new(name: 'User Example', email: 'user@example.com')
    user.save
    visit login_path
    fill_in 'Email', with: 'user@example.com'
    click_button 'Sign in'

    user1.user_events.create!(attended_event: event)
    user2.user_events.create!(attended_event: event)
    user3.user_events.create!(attended_event: event)

    visit event_path(event)
    expect(page).to have_content('user1')
    expect(page).to have_content('user2')
    expect(page).to have_content('user3')
  end

  scenario 'Index with all events' do
    Event.create(name: 'event1', location: 'somewhere',
                 date_event: '2015/1/9-18:10', creator: user_creator)
    Event.create(name: 'event2', location: 'somewhere',
                 date_event: '2015/1/9-18:10', creator: user_creator)
    Event.create(name: 'event3', location: 'somewhere',
                 date_event: '2021/1/9-18:10', creator: user_creator)
    Event.create(name: 'event4', location: 'somewhere',
                 date_event: '2021/1/9-18:10', creator: user_creator)
    Event.create(name: 'event5', location: 'somewhere',
                 date_event: '2022/1/9-18:10', creator: user_creator)

    visit events_path
    expect(page).to have_content('event1')
    expect(page).to have_content('event2')
    expect(page).to have_content('event3')
    expect(page).to have_content('event4')
    expect(page).to have_content('event5')
  end
end
