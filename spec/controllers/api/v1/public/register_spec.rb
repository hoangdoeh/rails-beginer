require 'rails_helper'

RSpec.describe 'User Registration API', type: :request do
  let(:url) { '/api/v1/public/register' }

  describe 'POST /register' do
    context 'with valid params' do
      let(:valid_params) do
        {
          username: 'testuser',
          password: 'securepassword'
        }
      end

      it 'creates a new user and returns 201' do
        expect {
          post url, params: valid_params
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json['message']).to eq('User created successfully')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { username: '' } }

      it 'returns 422 with error messages' do
        post url, params: invalid_params

        expect(response).to have_http_status(422)
        json = JSON.parse(response.body)
        expect(json['error']).to include("password is missing", "username is invalid")
      end
    end
  end
end
