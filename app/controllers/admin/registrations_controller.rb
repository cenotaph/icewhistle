# frozen_string_literal: true

class Admin::RegistrationsController < Admin::BaseController
  responders :location, :flash
  respond_to :html, :json

  def destroy
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.find(params[:id])
    @registration.discard
    redirect_to admin_event_registrations_path(@event)
  end

  def edit
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.find(params[:id])
  end


  def index
    @event = Event.find(params[:event_id])
    @registrations = @event.registrations
    respond_to do |format|
      # format.json {
      #   render json: @events.to_json(only: [:id, :name]), callback: params[:callback]
      # }
      format.html
    end
  end

  def update
    @event = Event.find(params[:event_id])
    @registration = @event.registrations.find(params[:id])
    if @registration.update(registration_params)
      redirect_to admin_event_registrations_path(@event)
    end
  end

  protected

  def registration_params
    params.require(:registration).permit(:name, :email, :phone, :comments, :question1, :website, :question2, :question3)      
  end
 
end
