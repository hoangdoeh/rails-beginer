# frozen_string_literal: true

class TodoCreator
  def initialize(name, deadline, user_id)
    @name = name
    @deadline = deadline
    @user_id = user_id
  end

  def handle
    todo = Todo.new(deadline: @deadline, name: @name, status: 0, user_id: @user_id)
    todo.save!
    NotifyWhenCreateTodo.perform_async(todo.id)
    todo
  end
end
