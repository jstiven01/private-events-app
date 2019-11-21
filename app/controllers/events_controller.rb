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
  end

  def index
    @events = Event.paginate(page: params[:page], per_page: 6).order(created_at: :desc)
  end

  private

  def events_params
    params.require(:event).permit(:name, :location, :date, :description)
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end
end
