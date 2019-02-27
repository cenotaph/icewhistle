# frozen_string_literal: true

module Api::V1
  # bundle types controller. admins only?
  class EventsController < ApiController
    before_action :authenticate_user!, except: %i[show past index]
    # skip_load_and_authorize_resource only: %i[create destroy index]
    respond_to :json

    def index
      @events = Event.where(["end_at >= ?", Time.current.utc])
      render json: EventSerializer.new(@events, include: [:photos, :registrations]).serialized_json, status: 200
    end

    def past
      @events = Event.where(["end_at <= ?", Time.current.utc])
      render json: EventSerializer.new(@events, include: [:photos, :registrations]).serialized_json, status: 200
    end

    def show
      @event = Event.friendly.find(params[:id])
      render json: EventSerializer.new(@event, include: [:photos]).serialized_json, status: 200
    end
  end
end
