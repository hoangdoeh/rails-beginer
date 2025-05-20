require 'rails_helper'

RSpec.describe 'Public Login API', type: :request do
  let!(:user) { create(:user, password: 'password123', password_confirmation: 'password123') }

  describe 'POST /api/v1/public/login' do
    context 'when credentials are valid' do
      it 'returns a JWT token and status 201' do
        post '/api/v1/public/login', params: { username: user.username, password: 'password123' }

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('token')
        expect(json_response['token']).to be_a(String)
      end
    end

    context 'when password is incorrect' do
      it 'returns unauthorized status' do
        post '/api/v1/public/login', params: { username: user.username, password: 'wrong_password' }

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Unauthorized')
      end
    end

    context 'when username does not exist' do
      it 'returns unauthorized status' do
        post '/api/v1/public/login', params: { username: 'nonexistent_user', password: 'any_password' }

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Unauthorized')
      end
    end
  end
end
