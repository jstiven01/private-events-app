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
    expect(page).to have_content('user@example.com')
  end

  # scenario "Invalid signup information" do
  #    get signup_path
  #    #assert_select 'form[action="/signup"]'

  #    assert_no_difference 'User.count' do
  #      post signup_path, params: { user:{ name: 'Johan Tinjaca',
  #                                        email: 'user@invalid',
  #                                        password: 'foo',
  #                                        password_confirmation: 'bar' }}
  #    end

  #    assert_template 'users/new'
  #    assert_select 'div#error_explanation'
  #    assert_select 'div.field_with_errors'
  #    assert_select 'div#error_explanation>ul>li:first-child', "Email is invalid"
  #    assert_select 'div#error_explanation>ul>li:nth-child(2)', "Password confirmation doesn't match Password"
  #    assert_select 'div#error_explanation>ul>li:last-child', "Password is too short (minimum is 6 characters)"
  # end
end
