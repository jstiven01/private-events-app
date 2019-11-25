# frozen_string_literal: true

class UserEventsController < ApplicationController
  before_action :logged_in_user, only: %i[create]
  def create
    event = Event.find(user_event_params[:attended_event])
    @userevent = UserEvent.new(attendee: current_user, attended_event: event)
    if @userevent.save
      flash[:success] = 'You were registered successfully'
    else
      flash.now[:danger] = 'You are already registered!'
    end
    redirect_to event_path(@userevent.attended_event)
  end

  private

  def user_event_params
    params.require(:user_event).permit(:attended_event)
  end
end
