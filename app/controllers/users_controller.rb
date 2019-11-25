# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = 'Welcome to the Private Events!!'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'Email already registered'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @upcoming_events = @user.upcoming_events
    @prev_events = @user.previous_events
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
