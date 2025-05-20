module Api
  module V1
    class Todos < Grape::API
      helpers do
        def current_user
          env["user"]
        end

        def find_todo
          Todo.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          error!({ error: "Todo not found" }, 404)
        end
      end

      resource :todos do
        desc "Get all todo"
        get do
          todos = Todo.all.to_a
          present todos
        end

        desc "Get a specific todo"
        params do
          requires :id, type: Integer
        end
        get ":id" do
          todo = find_todo
          present todo
        end

        desc "Create a todo"
        params do
          requires :name, type: String
          requires :deadline, type: DateTime
          optional :status, type: Integer
        end
        post do
          service = TodoService::CreateTodo.new(params[:name], params[:deadline], current_user.id)
          service.call
          present service.data
        end

        desc "Update a todo"
        params do
          requires :id, type: Integer
          optional :name, type: String
          optional :deadline, type: DateTime
          optional :status, type: Integer
        end
        put ":id" do
          todo = find_todo
          if todo.update(declared(params).except(:id).merge(user_id: current_user.id))
            present todo
          else
            error!({ errors: todo.errors.full_messages }, 422)
          end
        end

        desc "Delete a todo"
        params do
          requires :id, type: Integer
        end
        delete ":id" do
          todo = find_todo
          todo.destroy
          status 204
        end
      end
    end
  end
end
