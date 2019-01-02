# frozen_string_literal: true

module Api::V1
  # bundle types controller. admins only?
  class RegistrationsController < ApiController
    # before_action :authenticate_user!, except: %i[show]
    # skip_load_and_authorize_resource only: %i[create destroy index]
    respond_to :json

    def create
      @event = Event.friendly.find(params[:event_id])
      @registration = Registration.new(registration_params)
      @event.registrations << @registration
      if verify_recaptcha(model: @registration) && @registration.save
        NotificationsMailer.registered_event(@event, @registration).deliver
        head :no_content
      else
        render json: { errors: [{ detail: @registration.errors.full_messages.join('; '),
                                        title: 'Error creating registration',
                                        status: 422
                                }]
                            }, status: 422
      end

    end

    protected

    def registration_params
      params.require(:registration).permit(:name, :email, :phone, :comments, :question1, :website, :question2, :question3)      
    end
  end
end
