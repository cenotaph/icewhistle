# frozen_string_literal: true

class Admin::EventsController < Admin::BaseController
  responders :location, :flash
  respond_to :html, :json

  def create
    @event = Event.new(event_params)
    if @event.save
      respond_with @event, location: -> { admin_events_path }
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy!
    redirect_to admin_events_path
  end

  def edit
    @event = Event.friendly.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def index
    @events = apply_scopes(Event).page(params[:page]).per(30)
    respond_to do |format|
      format.json {
        render json: @events.to_json(only: [:id, :name]), callback: params[:callback]
      }
      format.html
    end
  end

  def update
    @event = Event.friendly.find(params[:id])
    if @event.update(event_params)
      respond_with @event, location: -> { admin_events_path }
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :latitude, :longitude, :description, :start_at, :end_at, :link1, :link2, :expires, :registration, :question1, :question2, :question3, :reg_limit, :extra_date)
  end
 
end
