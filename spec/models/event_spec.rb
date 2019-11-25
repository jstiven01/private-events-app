# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'should return past and upcoming events' do
    creator = User.new(name: 'Johan', email: 'foo@example.com')
    event1 = Event.new(name: 'Event 1', location: 'Medellin', date_event: '2022/01/01', creator: creator)
    event2 = Event.new(name: 'Event 2', location: 'Medellin', date_event: '2022/01/01', creator: creator)
    event3 = Event.new(name: 'Event 3', location: 'Medellin', date_event: '2000/01/01', creator: creator)
    event1.save
    event2.save
    event3.save
    expect(Event.past.length).to eq(1)
    expect(Event.upcoming.length).to eq(2)
  end
end
