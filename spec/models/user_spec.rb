# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'should be valid' do
      user = User.new(name: 'Johan', email: 'foo@example.com').save
      expect(user).to eq(true)
    end
  end
  context 'Upcoming Events' do
    it 'should return upcoming events' do
      creator = User.new(name: 'Johan', email: 'foo@example.com')
      attendee = User.new(name: 'Johan', email: 'foo@example.com')
      creator.save
      attendee.save
      event1 = Event.new(name: 'Event 1', location: 'Medellin', date_event: '2022/01/01', creator: creator)
      event2 = Event.new(name: 'Event 2', location: 'Medellin', date_event: '2022/01/01', creator: creator)
      event3 = Event.new(name: 'Event 3', location: 'Medellin', date_event: '2000/01/01', creator: creator)
      event1.save
      event2.save
      event3.save
      event1.user_events.create!(attendee: attendee)
      event2.user_events.create!(attendee: attendee)
      event3.user_events.create!(attendee: attendee)
      expect(attendee.upcoming_events.length).to eq(2)
    end
  end

  context 'Past Events' do
    it 'should return past events' do
      creator = User.new(name: 'Johan', email: 'foo@example.com')
      attendee = User.new(name: 'Johan', email: 'foo@example.com')
      creator.save
      attendee.save
      event1 = Event.new(name: 'Event 1', location: 'Medellin', date_event: '2022/01/01', creator: creator)
      event2 = Event.new(name: 'Event 2', location: 'Medellin', date_event: '2022/01/01', creator: creator)
      event3 = Event.new(name: 'Event 3', location: 'Medellin', date_event: '2000/01/01', creator: creator)
      event1.save
      event2.save
      event3.save
      event1.user_events.create!(attendee: attendee)
      event2.user_events.create!(attendee: attendee)
      event3.user_events.create!(attendee: attendee)
      expect(attendee.previous_events.length).to eq(1)
    end
  end
end
