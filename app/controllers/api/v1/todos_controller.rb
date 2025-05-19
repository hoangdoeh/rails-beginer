# app/controllers/api/v1/todos_controller.rb

class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: [ :show, :update, :destroy ]
  before_action :set_user
  protect_from_forgery with: :null_session

  def index
    todo = Rails.cache.fetch("apiv1todos", expires_in: 12.hours) do
      Rails.logger.info "CACHE MISS - querying DB"
      Todo.all.to_a
    end
    render json: todo
  end
  # serializer
  # rake task
  # db migration
  # job - sidekiq
  # viết view cơ bản, gửi mail
  # test - RSpec
  def show
    render json: @todo
  end

  def create
    params = todo_params
    creator = TodoCreator.new(params[:name], params[:deadline], @user.id)
    todo = creator.handle
    render json: todo
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Todo not found" }, status: :not_found
  end

  def set_user
    @user = request.env["user"]
  end

  def todo_params
    params.require(:todo).permit(:name, :deadline, :status)
  end
end
