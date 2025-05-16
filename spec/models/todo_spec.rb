require 'rails_helper'

RSpec.describe Todo, type: :model do
  let!(:user) { User.create(username: "tester", password: "123123123") }
  context 'validations' do
    it 'does not save without name and deadline' do
      todo = Todo.new
      expect(todo.save).to be false

      todo = Todo.new(name: "Test case")
      expect(todo.save).to be false

      todo = Todo.new(deadline: Date.today)
      expect(todo.save).to be false
    end

    it 'saves with valid attributes' do
      todo = Todo.new(name: "Test case 2", deadline: Date.today, status: 0, user_id: user.id)
      result = todo.save!
      expect(result).to be true
    end
  end
end