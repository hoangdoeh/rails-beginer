# frozen_string_literal: true

class Api::V1::Public::UserController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    puts user_params
    user = User.new(user_params)
    if user.save
      RegisterMailer.with(user: user).registered_mail.deliver_later
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
