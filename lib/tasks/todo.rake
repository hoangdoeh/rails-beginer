namespace :todo do
  desc "TODO task for admin"
  task create_todo: :environment do
    name = ENV["name"]
    user = ENV["user"]
    creator = TodoService::CreateTodo.new(name, Date.tomorrow, user)
    creator.call
  end
end
