# frozen_string_literal: true

require 'swagger_helper'

describe 'Registrations API' do
  path '/api/v1/events/{event_id}/registrations' do
    parameter name: :event_id, in: :path, type: :string
    post 'Register for an event' do
      tags 'Events'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :registration, in: :body, schema: { '$ref': '#/definitions/registration_object' }

      before(:all) do
        @event = FactoryBot.create(:event)
        reg = FactoryBot.create(:registration, event: @event)
        @registration = { registration:  reg  }
      end

      response '204', 'event registration created' do
        let(:event_id) { @event.slug }
        let(:registration) { @registration }
        run_test!
      end

      response '404', 'not found' do
        let(:event_id) { FactoryBot.create(:event).id  + 1 }
        let(:registration) { @registration }
        run_test!
      end
    end
  end
end