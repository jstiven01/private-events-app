# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User sign in', type: :feature do
  scenario 'Login with valid information' do
    user = User.new(name: 'User Example', email: 'user@example.com')
    user.save
    visit login_path
    expect(page).to have_content('SIGN IN')
    assert_selector 'form[action="/login"]'
    fill_in 'Email', with: 'user@example.com'
    click_button 'Sign in'
    expect(current_path).to eql("/users/#{user.id}")
    expect(page).to have_content('User Example')
  end

  scenario 'Login with valid information followd by logout ' do
    user = User.new(name: 'User Example', email: 'user@example.com')
    user.save
    visit login_path
    expect(page).to have_content('SIGN IN')
    assert_selector 'form[action="/login"]'
    fill_in 'Email', with: 'user@example.com'
    click_button 'Sign in'
    expect(current_path).to eql("/users/#{user.id}")
    expect(page).to have_content('User Example')
    expect(page).to have_link(href: '/logout')
    click_link 'Sign out'
    expect(current_path).to eql('/')
  end
end
