# frozen_string_literal: true

class Api::V1::MeController < ApplicationController
  protect_from_forgery with: :null_session

  def me
    user = request.env["user"]
    render json: user
  end
end
