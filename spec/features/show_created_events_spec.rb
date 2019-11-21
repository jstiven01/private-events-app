# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User sign in', type: :feature do
  let(:user) { User.create(name: 'user1', email: 'user1@example.com') }
  let(:event1) { Event.create(name: 'event1', location: 'somewhere', date_event: '2018/10/10-15:10') }
  let(:event2) { Event.create(name: 'event2', location: 'somewhere', date_event: '2018/10/11-15:10') }
  let(:event3) { Event.create(name: 'event3', location: 'somewhere', date_event: '2018/10/12-15:10') }

  scenario 'Show events created by a user' do
    user.save
    event1.creator_id = user.id
    event2.creator_id = user.id
    event3.creator_id = user.id
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
    sleep(5)
    expect(page).to have_content(event3.name)
  end
end
