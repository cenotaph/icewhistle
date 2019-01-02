# # frozen_string_literal: true

# require 'rails_helper'
# require 'pp'

# RSpec.describe 'User registration', type: :request do
#   let(:json_headers) { { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json' } }
#   let!(:user_attributes) {
#     { email: 'test@foo.com', phone: Faker::PhoneNumber.phone_number,
#       password: 'testpassword', first_name: Faker::Name.first_name,
#       last_name: Faker::Name.last_name }
#   }

#   before(:each) do
#     @user = FactoryBot.create(:user)
#   end

#   describe 'POST /auth' do
#     context 'when registering invalid user' do
#       before do
#         post '/auth', params:  { email: 'invalid email', password: '', last_name: 'Bad User',
#                                 first_name: 'no one' }.to_json, headers: json_headers
#       end

#       it 'is in JSON format' do
#         expect(response.header['Content-Type']).to include('application/json')
#       end

#       it 'returns status code 422' do
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(JSON.parse(response.body)['status']).to eq('error')
#       end
#     end

#     context 'when registering valid user' do
#       before do
#         post '/auth', params:  user_attributes.to_json,
#                       headers: json_headers
#       end

#       it 'returns status code 200' do
#         expect(response).to have_http_status(:ok)
#       end

#       it 'returns correct username' do
#         @user_id = json['data']['id']
#         expect(json['data']['first_name']).to eq(user_attributes[:first_name])
#       end

#       it 'sends a confirmation email' do
#         expect(ActionMailer::Base.deliveries.count).to eq 1
#       end

#       it 'renders the receiver email' do
#         expect(ActionMailer::Base.deliveries.first['to'].value).to eq(user_attributes[:email])
#       end

#       it 'renders the sender email' do
#         expect(ActionMailer::Base.deliveries.first.from).to eq(['info@trenox.fi'])
#       end

#       it 'can be confirmed' do
#         user = User.find_by(email: 'test@foo.com')
#         get '/auth/confirmation', params: { confirmation_token: user.confirmation_token }

#         expect(json['status']).to eq('success')
#         expect(response).to have_http_status(:ok)
#       end

#       context 'when registering using with duplicate info' do
#         before do
#           second_attributes = user_attributes
#           post '/auth', params:  second_attributes.to_json,
#                         headers: json_headers
#         end

#         it 'returns status code 422' do
#           expect(response).to have_http_status(:unprocessable_entity)
#         end
#       end
#     end
#   end

#   describe 'POST /auth/sign_in' do
#     context 'before email is verified, should not be able to sign in' do
#       before do
#         post '/auth/sign_in', params: { email: @user.email, password: @user.password }
#       end

#       it 'returns 401' do
#         expect(response).to have_http_status(:unauthorized)
#       end

#       it 'has success = false' do
#         expect(json['success']).to be false
#       end
#     end
#   end

#   describe 'GET /auth/confirmation' do
#     before(:all) do
#       get '/auth/confirmation', params: { confirmation_token: @user.confirmation_token }
#     end

#     it 'returns status code 200' do
#       expect(response).to have_http_status(:ok)
#     end

#     it 'returns a success' do
#       expect(json['status']).to eq('success')
#     end
#   end

#   describe 'POST /auth/sign_in' do
#     context 'after email is verified, should be able to sign in' do
#       before do
#         post '/auth/sign_in', params: { email: @user.email, password: @user.password }
#       end

#       it 'returns 200' do
#         expect(response).to have_http_status(:ok)
#       end

#       it 'has the access token and uid in the headers' do
#         expect(response.headers['access-token']).not_to be_empty
#         expect(response.header['uid']).to eq(@user.email)
#       end
#     end
#   end

#   describe 'GET /auth/confirmation' do
#     context 'when trying a bogus confirmation' do
#       before do
#         get '/auth/confirmation', params:  { confirmation_token: 'bogus_confirm' }.to_json,
#                                   headers: json_headers
#       end

#       it 'returns 422' do
#         expect(response).to have_http_status(:unprocessable_entity)
#       end
#     end
#   end

#   describe 'PUT /users/:id' do
#     before(:all) do
#       json_headers = { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json' }
#       # register a user again
#       post '/auth', params:  { email: 'test@foo.com', phone: Faker::PhoneNumber.phone_number, password: 'testpassword', first_name: 'Mr.', last_name: 'Test' }.to_json,
#                     headers: json_headers
#       @newuser_id = json['data']['id']
#       @newuser = User.find(@newuser_id)

#       @auth_headers = @newuser.create_new_auth_token
#     end

#     context 'when updating but not signed in' do
#       before do
#         put "/v1/users/#{@newuser_id}", params:  { first: 'Changed X.' }.to_json,
#                                         headers: json_headers
#       end

#       it 'returns status code 401' do
#         expect(response).to have_http_status(:unauthorized)
#       end
#     end

#     context 'when updating but signed in as different user' do
#       before do
#         post '/auth', params:  { email: 'test2@foo.com', phone: Faker::PhoneNumber.phone_number,
#           password: 'testpassword', first_name: 'Mr. Test', last_name: 'mrtest43' }.to_json,
#                       headers: json_headers

#         @second_user = User.find(json['data']['id'])
#         # confirm second user so we don't get warden throw error
#         @second_user.confirmed_at = Time.zone.now
#         @second_user.save
#         @second_auth_headers = @second_user.create_new_auth_token

#         sign_in @second_user
#         put "/v1/users/#{@newuser.id}", params:  { first_name: 'Changed X.' }.to_json,
#                                         headers: json_headers.merge('Uid'          => @second_auth_headers['uid'],
#                                                                     'Access-Token' => @second_auth_headers['access-token'],
#                                                                     'Client'       => @second_auth_headers['client'])
#       end

#       it 'returns status code 403' do
#         expect(response).to have_http_status(:forbidden)
#       end
#     end

#     context 'when updating self' do
#       before do
#         @newuser.confirmed_at = Time.zone.now
#         @newuser.save
#         @auth_headers = @newuser.create_new_auth_token
#         sign_in @newuser
#         put "/v1/users/#{@newuser.id}",
#             params:  { first_name: 'X.', last_name: 'Surname' }.to_json,
#             headers: json_headers.merge('Uid'          => @auth_headers['uid'],
#                                         'Access-Token' => @auth_headers['access-token'],
#                                         'Client'       => @auth_headers['client'])
#       end

#       it 'returns status code 200' do
#         expect(response).to have_http_status(:ok)
#       end

#       it 'has changed name' do
#         expect(json['data']['attributes']['first_name']).to eq('X.')
#       end
#     end
#   end

#   describe 'GET /users' do
#     context 'when not signed in' do
#       before do
#         get '/v1/users'
#       end

#       it 'returns 401' do
#         expect(response).to have_http_status(:unauthorized)
#       end
#     end

#     context 'when not an admin' do
#       before do
#         @user.confirmed_at = Time.zone.now
#         @user.save
#         sign_in @user

#         @headers = @user.create_new_auth_token
#         get '/v1/users', headers: json_headers.merge('Uid'          => @headers['uid'],
#                                                      'Access-Token' => @headers['access-token'],
#                                                      'Client'       => @headers['client'])
#       end

#       it 'returns 403' do
#         expect(response).to have_http_status(:forbidden)
#       end
#     end

#     # context 'when an admin' do
#     #   before do
#     #     sign_in @admin_user
#     #     @admin_headers = @admin_user.create_new_auth_token
#     #     get '/v1/users', headers: json_headers.merge('Uid'          => @admin_headers['uid'],
#     #                                                  'Access-Token' => @admin_headers['access-token'],
#     #                                                  'Client'       => @admin_headers['client'])
#     #   end

#     #   it 'returns 200' do
#     #     expect(response).to have_http_status(:ok)
#     #   end

#     #   it 'has at least 2 users' do
#     #     expect(json['data'].size).to be >= 2
#     #   end
#     # end
#   end
# end
