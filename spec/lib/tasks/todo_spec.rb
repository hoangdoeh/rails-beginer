require 'rails_helper'
require 'rake'

RSpec.describe 'todo:create_todo' do
  let!(:user) { create(:user, password: 'password123', password_confirmation: 'password123') }

  before(:all) do
    Rake::Task.define_task(:environment)
    Rake.application.rake_require("tasks/todo")
  end

  before do
    @task = Rake::Task["todo:create_todo"]
    @task.reenable  # Cho phép chạy lại task trong mỗi example
  end

  it "create new todo" do
    name = "Today test it"
    ENV["name"] = name
    ENV["user"] = user.id.to_s
    expect {
      @task.invoke
    }.to change { Todo.count }.by(1)

    expect(Todo.where(name: name).exists?).to be_truthy
  end
end
