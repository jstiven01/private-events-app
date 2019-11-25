# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :logged_in_user, only: %i[new create]
  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(events_params)
    if @event.save
      flash[:success] = 'Event created successfully'
      redirect_to event_path(@event)
    else
      flash.now[:danger] = 'Failed to create a new event'
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    @userevent = UserEvent.new
  end

  def index
    @events_upcoming = Event.upcoming
    @events_past = Event.past
  end

  private

  def events_params
    params.require(:event).permit(:name, :location, :date_event, :description)
  end
end
