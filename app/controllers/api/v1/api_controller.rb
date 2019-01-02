# frozen_string_literal: true

module Api::V1
  # This is the parent API controller which the individual APIs inherit things from
  class ApiController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    protect_from_forgery with: :null_session

    # skip_load_and_authorize_resource only: :home
    load_and_authorize_resource

    def home
      render json: {}
    end
  end
end
