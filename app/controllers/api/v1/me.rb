module Api
  module V1
    class Me < Grape::API
      helpers do
        def current_user
          env["user"]
        end
      end

      resource :me do
        desc "The current user information"

        get do
          present current_user
        end
      end
    end
  end
end


class Api::V1::MeController < ApplicationController
  protect_from_forgery with: :null_session

  def me
    user = request.env["user"]
    render json: user
  end
end
