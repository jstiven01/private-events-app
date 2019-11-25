# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User sign up', type: :feature do
  scenario 'Valid signup information' do
    visit new_user_path
    expect(page).to have_content('SIGN UP')
    assert_selector 'form[action="/users"]'
    expect do
      fill_in 'Name', with: 'Johan Tinjaca'
      fill_in 'Email', with: 'user@example.com'
      click_button 'Create my account'
    end.to change(User, :count).by(1)
    expect(current_path).to eql("/users/#{User.last.id}")
    expect(page).to have_content('Johan Tinjaca')
  end
end
