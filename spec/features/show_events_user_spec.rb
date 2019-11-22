# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show events related to user', type: :feature do
  let(:user) { User.new(name: 'user1', email: 'user1@example.com') }
  let(:event1) { Event.new(name: 'event1', location: 'somewhere', date_event: '2018/10/10-15:10', creator: user) }
  let(:event2) { Event.new(name: 'event2', location: 'somewhere', date_event: '2018/10/11-15:10', creator: user) }
  let(:event3) { Event.new(name: 'event3', location: 'somewhere', date_event: '2018/10/12-15:10', creator: user) }
  let(:attendee) { User.new(name: 'attendee', email: 'attendee@example.com') }

  scenario 'Show events created by a user' do
    user.save
    event1.save
    event2.save
    event3.save
    visit login_path
    expect(page).to have_content('SIGN IN')
    assert_selector 'form[action="/login"]'
    fill_in 'Email', with: user.email
    click_button 'Sign in'
    expect(current_path).to eql("/users/#{user.id}")
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
    expect(page).to have_content(event1.name)
    expect(page).to have_content(event2.name)
    expect(page).to have_content(event3.name)
  end

  scenario 'User’s Show page display a list of events they are attending' do
    user.save
    attendee.save
    event1.save
    event2.save
    event3.save
    event1.user_events.create!(attendee: attendee)
    event2.user_events.create!(attendee: attendee)
    event3.user_events.create!(attendee: attendee)
    visit login_path
    expect(page).to have_content('SIGN IN')
    fill_in 'Email', with: attendee.email
    click_button 'Sign in'
    expect(current_path).to eql("/users/#{attendee.id}")
    expect(page).to have_content(attendee.name)
    expect(page).to have_content(attendee.email)
    expect(page).to have_content(event1.name)
    expect(page).to have_content(event2.name)
    expect(page).to have_content(event3.name)
  end

  scenario 'User’s Show page display without events' do
    attendee.save
    visit login_path
    expect(page).to have_content('SIGN IN')
    fill_in 'Email', with: attendee.email
    click_button 'Sign in'
    expect(current_path).to eql("/users/#{attendee.id}")
    expect(page).to have_content(attendee.name)
    expect(page).to have_content(attendee.email)
  end
end
