# frozen_string_literal: true

class Api::V1::Public::LoginController < ApplicationController
  protect_from_forgery with: :null_session

  def login
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(sub: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
