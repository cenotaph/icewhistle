# frozen_string_literal: true

require 'swagger_helper'

describe 'Events API' do
  path '/api/v1/events/{id}' do
    parameter name: :id, in: :path, type: :string
    get 'Show an event' do
      tags 'Events'
      produces 'application/json'
      consumes 'application/json'


      response '200', 'event information retrieved' do
        let(:id) { FactoryBot.create(:event).slug }
        run_test!
      end

      response '404', 'not found' do
        let(:id) { FactoryBot.create(:event).id  + 1 }
        run_test!
      end
    end
  end
end
