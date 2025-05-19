namespace :todo do
  desc "TODO task for admin"
  task create_todo: :environment do
    name = ENV["name"]
    creator = TodoCreator.new(name, Date.tomorrow, 1)
    creator.handle
  end
end
