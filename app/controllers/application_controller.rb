# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  helper_method :current_user?

  # Returns true if the user is logged in,il false otherwise.
  def logged_in?
    !current_user.nil?
  end

  helper_method :logged_in?

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end
end
