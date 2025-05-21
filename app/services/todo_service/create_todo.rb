# frozen_string_literal: true

module TodoService
  class CreateTodo < Base::BaseService
    attr_reader :data
    def initialize(name, deadline, user_id)
      @name = name
      @deadline = deadline
      @user_id = user_id
    end

    def call
      todo = Todo.new(deadline: @deadline, name: @name, status: 0, user_id: @user_id)
      todo.save
      TodoJobs::NotifyWhenCreateTodo.perform_later(todo.id)
      @data = todo
    end
  end
end
