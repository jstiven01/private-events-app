# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #show' do
    it 'returns http success' do
      creator = User.new(name: 'Johan', email: 'foo@example.com')
      event1 = Event.new(name: 'Event 1', location: 'Medellin', date_event: '2022/01/01', creator: creator)
      event1.save
      get :show, params: { id: event1.id }
      expect(response).to have_http_status(:success)
    end
  end
end
