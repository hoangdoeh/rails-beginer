module TodoJobs
  class CreateTodoForAdmin < ActiveJob::Base
    def perform(name)
      name = "Task of the day #{Date.tomorrow.strftime('%Y-%m-%d')}"
      service = TodoService::CreateTodo.new(name, Date.tomorrow, 1)
      service.call
      service.data
    end
  end
end
